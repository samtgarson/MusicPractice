//
//  IntervalPractice.swift
//  MusicPractice
//
//  Created by Sam Garson on 19/07/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import CoreData
import MusicTheory

extension IntervalPractice: BaseEntityProtocol, PracticeEntityProtocol {
  var interval: Interval? {
    get {
      guard let intervalId = intervalId else { return nil }
      
      do {
        return try JSONDecoder().decode(Interval.self, from: Data(intervalId.utf8))
      } catch let err {
        print(err)
        return nil
      }
    }
    set {
      do {
        self.intervalId = try String(data: JSONEncoder().encode(newValue), encoding: .utf8)
      } catch let err {
        print(err)
      }
    }
  }
}
