//
//  TheoryService.swift
//  music-practice
//
//  Created by Sam Garson on 13/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import MusicTheorySwift

public enum TheoryType: String {
  case Scale = "Scale"
}

class TheoryService {
  internal init(_ type: TheoryType) {
    self.type = type
  }
  
  let type: TheoryType
  
  var level: Int {
    get { UserDefaults.standard.integer(forKey: "\(type)Level") }
    set { UserDefaults.standard.set(newValue, forKey: "\(type)Level") }
  }
  
  var next: Practiceable {
    availableItems.sorted {
      PracticePerformanceService(allPractices[$0]!).priority > PracticePerformanceService(allPractices[$1]!).priority
    }.first!
  }
  
  var availableItems: [Practiceable] {
    items[0...level].flatMap { $0 }
  }
  
  private var allPractices: [Practiceable: [PracticeEntityProtocol]] {
    switch type {
    case .Scale:
      let practices = Array(RequestFactory.call(ScalePractice.self).wrappedValue)
      return Dictionary(grouping: practices, by: { Practiceable.scale(($0 as! ScalePractice).scale!) })
    }
  }
  
  private var items: [[Practiceable]] {
    switch type {
    case .Scale:
      return TheoryService.scaleLevels
    }
  }
}
