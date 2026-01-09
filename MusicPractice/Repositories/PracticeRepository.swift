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
  func createPractice(_ item: Practiceable, _ score: Int, _ minutesPracticed: Int = 0) -> PracticeEntityProtocol? {
    switch item {
    case .scale(let scale):
      let newPractice = try! ScalePractice.fromScale(
        scale: scale,
        minutesPracticed: minutesPracticed,
        score: score
      )
      try! modelRepo.upsert(newPractice)
      return newPractice

    case .interval(let interval):
      let newPractice = try! IntervalPractice.fromInterval(
        interval: interval,
        minutesPracticed: minutesPracticed,
        score: score
      )
      try! modelRepo.upsert(newPractice)
      return newPractice
      
    case .song(let song):
      let newPractice = SongPractice(score: score, song: song, minutesPracticed: minutesPracticed)
      try! modelRepo.upsert(newPractice)
      return newPractice
    }
  }
}
