//
//  TheoryService.swift
//  music-practice
//
//  Created by Sam Garson on 12/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import MusicTheorySwift

func createScale ( type: ScaleType, key keyType: Key.KeyType, accidental: Accidental = .natural) -> Scale {
  let key = Key(type: keyType, accidental: accidental)
  return Scale(type: type, key: key)
}

extension Scale: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(self.description)
  }
}

extension TheoryService {
  static let scaleLevels: [[Scale]] = [
    [createScale(type: .major, key: .c)],
    [
      createScale(type: .major, key: .g),
      createScale(type: .major, key: .f)
    ],
    [
      createScale(type: .major, key: .d),
      createScale(type: .major, key: .b, accidental: .flat),
      createScale(type: .minor, key: .a)
    ],
    [
      createScale(type: .major, key: .a),
      createScale(type: .major, key: .e, accidental: .flat),
      createScale(type: .minor, key: .d),
      createScale(type: .minor, key: .e)
    ],
    [
      createScale(type: .major, key: .a),
      createScale(type: .major, key: .e, accidental: .flat),
      createScale(type: .minor, key: .d),
      createScale(type: .minor, key: .e)
    ],
    [
      createScale(type: .major, key: .e),
      createScale(type: .major, key: .a, accidental: .flat),
      createScale(type: .minor, key: .b),
      createScale(type: .minor, key: .g)
    ],
    [
      createScale(type: .major, key: .b),
      createScale(type: .major, key: .d, accidental: .flat),
      createScale(type: .minor, key: .c),
      createScale(type: .minor, key: .f, accidental: .sharp)
    ],
    [
      createScale(type: .major, key: .f, accidental: .sharp),
      createScale(type: .minor, key: .f),
      createScale(type: .minor, key: .c, accidental: .sharp)
    ],
    [
      createScale(type: .minor, key: .a, accidental: .flat),
      createScale(type: .minor, key: .e, accidental: .flat),
      createScale(type: .minor, key: .b, accidental: .flat)
    ]
  ]
}
