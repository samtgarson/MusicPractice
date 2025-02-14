//
//  ModelRepository.swift
//  MusicPractice
//
//  Created by Sam Garson on 12/02/2025.
//

import SwiftData
import SwiftUI

class ModelRepository {
  var container: ModelContainer

  init(with container: ModelContainer = Database.instance.container) {
    self.container = container
  }

  /// Create or update this item in the database
  @MainActor
  func upsert(_ record: any PersistentModel) throws {
    context.insert(record)
    try context.save()
  }

  /// Remove this item from the database
  @MainActor
  func delete<Model: PersistentModel>(_ record: Model) throws {
    let recordId = record.persistentModelID
    try context.delete(model: Model.self, where: #Predicate<Model> { item in
      return item.persistentModelID == recordId
    })
    try context.save()
  }

  /// Find an item from the database
  @MainActor
  func find<Model: PersistentModel>(
    with query: Predicate<Model>,
    sortBy: [SortDescriptor<Model>] = []
  ) throws -> Model? {
    let records = try context.fetch(.init(predicate: query, sortBy: sortBy))
    return records.first
  }

  /// Find many items from the database
  @MainActor
  func query<Model: PersistentModel>(
    _ model: Model.Type = Model.self,
    with query: Predicate<Model> = Predicate.true,
    sortBy: [SortDescriptor<Model>] = []
  ) -> [Model] {
    do {
      return try context.fetch(.init(predicate: query, sortBy: sortBy))
    } catch {
      #if DEBUG
      print("Error fetching \(model): \(error)")
      #endif
      return []
    }
  }

  @MainActor
  private var context: ModelContext {
    container.mainContext
  }
}
