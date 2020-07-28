//
//  Interval.swift
//  music-practice
//
//  Created by Sam Garson on 19/07/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import MusicTheorySwift

extension Interval: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(self.description)
  }
}

