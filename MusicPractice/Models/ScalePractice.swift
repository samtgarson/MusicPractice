//
//  ScalePractice.swift
//  MusicPractice
//
//  Created by Sam Garson on 14/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import MusicTheory
import SwiftData


@Model class ScalePractice: PracticeEntityProtocol {
  var minutesPracticed: Int
  var createdAt: Date = Date()
  var scaleId: String
  var score: Int = 0

  init(score: Int, scaleId: String, minutesPracticed: Int, createdAt: Date = Date()) {
    self.createdAt = createdAt
    self.scaleId = scaleId
    self.score = score
    self.minutesPracticed = minutesPracticed
  }

  static func fromScale(
    scale: Scale,
    minutesPracticed: Int,
    score: Int = 0
  ) throws -> ScalePractice {
    let data = try JSONEncoder().encode(scale)
    let scaleId = String(decoding: data, as: UTF8.self)

    return ScalePractice(
      score: score,
      scaleId: scaleId,
      minutesPracticed: minutesPracticed
    )
  }

  var scale: Scale? {
    do {
      return try JSONDecoder().decode(Scale.self, from: Data(scaleId.utf8))
    } catch let err {
      print(err)
      return nil
    }
  }
}
