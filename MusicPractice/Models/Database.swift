//
//  Database.swift
//  MusicPractice
//
//  Created by Sam Garson on 12/02/2025.
//

import Foundation
import SwiftData

/// A wrapper around SwiftData ModelContainer
final class Database {
    static let instance = Database()
    static func forTest() -> Database {
        Database(useInMemoryStore: true)
    }

    @MainActor
    static func testInstance(with models: [any PersistentModel]) -> Database {
        let database = forTest(), context = database.container.mainContext
        models.forEach { model in context.insert(model) }
        try? context.save()
        return database
    }

    static let models: [any PersistentModel.Type] = [
      IntervalPractice.self,
      ScalePractice.self,
      SongPractice.self,
      Song.self
    ]

    let container: ModelContainer

    init(useInMemoryStore: Bool = false) {
        let schema = Schema(Database.models)
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: useInMemoryStore
        )
        do {
            container = try ModelContainer(
                for: schema,
                configurations: configuration
            )
            if useInMemoryStore { print("sqlite in memory") }
            else { print("sqlite3 \"\(configuration.url.path(percentEncoded: false))\"") }
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    @MainActor
    func reset() {
        do {
            let context = container.mainContext
            try Database.models.forEach { model in
                try context.delete(model: model)
            }
        } catch {
            print("Failed to clear all Country and City data.")
        }
    }
}
