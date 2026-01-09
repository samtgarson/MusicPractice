//
//  Song.swift
//  MusicPractice
//
//  Created by Sam Garson on 06/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import SwiftData


@Model final class Song {
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

extension Song: Codable {
  enum CodingKeys: CodingKey {
    case archivedAt, createdAt, title
  }

  convenience init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.init(
      title: try container.decode(String.self, forKey: .title),
      archivedAt: try container.decodeIfPresent(Date.self, forKey: .archivedAt),
      createdAt: try container.decode(Date.self, forKey: .createdAt)
    )
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(title, forKey: .title)
    try container.encode(archivedAt, forKey: .archivedAt)
    try container.encode(createdAt, forKey: .createdAt)
  }
}
