//
//  IntervalPractice.swift
//  MusicPractice
//
//  Created by Sam Garson on 19/07/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import MusicTheory
import SwiftData


@Model class IntervalPractice: PracticeEntityProtocol {
  var minutesPracticed: Int
  var createdAt: Date = Date()
  var intervalId: String
  var score: Int = 0

  init(intervalId: String, minutesPracticed: Int, score: Int = 0, createdAt: Date = Date()) {
    self.createdAt = createdAt
    self.minutesPracticed = minutesPracticed
    self.intervalId = intervalId
    self.score = score
  }

  static func fromInterval(
    interval: Interval,
    minutesPracticed: Int,
    score: Int = 0
  ) throws -> IntervalPractice {
    let data = try JSONEncoder().encode(interval)
    let intervalId = String(decoding: data, as: UTF8.self)

    return IntervalPractice(
      intervalId: intervalId,
      minutesPracticed: minutesPracticed,
      score: score
    )
  }

  var interval: Interval? {
    do {
      return try JSONDecoder().decode(Interval.self, from: Data(intervalId.utf8))
    } catch let err {
      print(err)
      return nil
    }
  }
}
