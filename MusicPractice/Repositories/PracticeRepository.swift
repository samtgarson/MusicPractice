//
//  PracticeRepository.swift
//  MusicPractice
//
//  Created by Sam Garson on 01/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import CoreData
import SwiftUI
import MusicTheory

class PracticeRepository {
  var modelRepo: ModelRepository

  init(modelRepo: ModelRepository = .init()) {
    self.modelRepo = modelRepo
  }

  @MainActor @discardableResult
  func createPractice(_ item: Practiceable, _ score: Int) -> PracticeEntityProtocol? {
    switch item {
    case .scale(let scale):
      let newPractice = ScalePractice(score: score)
      newPractice.scale = scale
      try! modelRepo.upsert(newPractice)
      return newPractice
    case .interval(let interval):
      let newPractice = IntervalPractice()
      newPractice.interval = interval
      newPractice.score = score
      try! modelRepo.upsert(newPractice)
      return newPractice
    case .song(let song):
      let newPractice = SongPractice(score: score, song: song)
      try! modelRepo.upsert(newPractice)
      return newPractice
    }
  }
}
