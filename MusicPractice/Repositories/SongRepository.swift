//
//  SongRepository.swift
//  MusicPractice
//
//  Created by Sam Garson on 01/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftData
import SwiftUI

enum SongFilter {
  case All
  case Active
  case Archived
}

class SongRepository {
  var modelRepo = ModelRepository()

  init(modelRepo: ModelRepository = ModelRepository()) {
    self.modelRepo = modelRepo
  }

  static func predicate(for filter: SongFilter) -> FetchDescriptor<Song> {
    switch filter {
    case .All:
      return .init(predicate: .true)
    case .Active:
      return .init(predicate: #Predicate { $0.archivedAt == nil })
    case .Archived:
      return .init(predicate: #Predicate { $0.archivedAt != nil })
    }
  }

  @MainActor @discardableResult
  func create(title: String) -> Song? {
    let newSong = Song(title: title)
    try! modelRepo.upsert(newSong)
    return newSong
  }

  @MainActor
  func archive(song: Song) {
    song.archive()
    try! modelRepo.upsert(song)
  }

  @MainActor
  func unarchive(song: Song) {
    song.unarchive()
    try! modelRepo.upsert(song)
  }
}
