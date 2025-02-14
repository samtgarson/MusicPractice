//
//  SongPractice.swift
//  MusicPractice
//
//  Created by Sam Garson on 06/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import SwiftData


@Model class SongPractice: PracticeEntityProtocol {
  var createdAt: Date = Date()
  var score: Int = 0
  @Relationship()
  var song: Song

  init(score: Int, song: Song, createdAt: Date = Date()) {
    self.score = score
    self.song = song
    self.createdAt = createdAt
  }
}
