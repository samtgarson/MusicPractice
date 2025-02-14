//
//  Song.swift
//  MusicPractice
//
//  Created by Sam Garson on 06/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import SwiftData


@Model class Song {
  var archivedAt: Date? = nil
  var createdAt: Date = Date()
  var title: String
  @Relationship(deleteRule: .cascade, inverse: \SongPractice.song)
  var practices: [SongPractice]

  init(title: String, archivedAt: Date? = nil, createdAt: Date = Date(), practices: [SongPractice] = []) {
    self.archivedAt = archivedAt
    self.createdAt = createdAt
    self.title = title
    self.practices = practices
  }

  func archive() {
    archivedAt = Date()
  }

  func unarchive() {
    archivedAt = nil
  }

  var practiceArray: [SongPractice] {
    practices.sorted(by: { a, b in a.createdAt <= b.createdAt })
  }
}
