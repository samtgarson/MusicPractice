//
//  TestSuiteWithDatabase.swift
//  MusicPractice
//
//  Created by Sam Garson on 14/02/2025.
//
@testable import MusicPractice
import SwiftData

@MainActor
class TestSuiteWithDatabase {
  let database = Database.forTest()

  var container: ModelContainer {
    return database.container
  }

  var repo: ModelRepository {
    return ModelRepository(with: container)
  }
}
