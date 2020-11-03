//
//  Scale.swift
//  music-practice
//
//  Created by Sam Garson on 19/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import MusicTheory

extension Scale: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(self.description)
  }
  
  var shortDescription: String {
    "\(key.description) \(type.description)"
  }
}
