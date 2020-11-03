//
//  ChordLevels.swift
//  music-practice
//
//  Created by Sam Garson on 19/07/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import MusicTheory

extension TheoryService {
  static let intervalLevels: [[Practiceable]] = [
    [
      .interval(.P5),
      .interval(.P4),
      .interval(.P1),
      .interval(.P8)
    ],
    [
      .interval(.M3),
      .interval(.m3),
      .interval(.M6),
      .interval(.m6)
    ],
    [
      .interval(.m2),
      .interval(.M2),
      .interval(.d4),
      .interval(.m7),
      .interval(.M7)
    ],
  ]
}
