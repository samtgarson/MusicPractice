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
  var createdAt: Date = Date()
  var scaleId: String?
  var score: Int = 0

  init(score: Int, scaleId: String? = nil, createdAt: Date = Date()) {
    self.createdAt = createdAt
    self.scaleId = scaleId
    self.score = score
  }

  var scale: Scale? {
    get {
      guard let scaleId = scaleId else { return nil }

      do {
        return try JSONDecoder().decode(Scale.self, from: Data(scaleId.utf8))
      } catch let err {
        print(err)
        return nil
      }
    }
    set {
      do {
        self.scaleId = try String(data: JSONEncoder().encode(newValue), encoding: .utf8)
      } catch let err {
        print(err)
      }
    }
  }
}
