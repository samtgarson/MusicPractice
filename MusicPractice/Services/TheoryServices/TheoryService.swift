//
//  TheoryService.swift
//  MusicPractice
//
//  Created by Sam Garson on 13/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import MusicTheory

public enum TheoryType: String {
  case Scale = "Scale"
  case Interval = "Interval"
}

@MainActor
class TheoryService {
  var repo: ModelRepository

  let MIN_PRACTICE_COUNT = 3

  init (
    _ type: TheoryType,
    repo: ModelRepository = .init()
  ) {
    self.type = type
    self.repo = repo
  }
  
  let type: TheoryType
  
  var level: Int {
    get { UserDefaults.standard.integer(forKey: "\(type)Level") }
    set { UserDefaults.standard.set(newValue, forKey: "\(type)Level") }
  }
  
  var next: Practiceable {
    availableItems.sorted {
      PracticePerformanceService(allPractices[$0, default: []]).priority
        > PracticePerformanceService(allPractices[$1, default: []]).priority
    }.first!
  }
  
  var currentLevel: [Practiceable] {
    levels[level]
  }
  
  var availableItems: [Practiceable] {
    levels[0...level].flatMap { $0 }
  }
  
  func levelIfPossible() -> Bool {
    guard canLevelUp else { return false }
    
    level += 1
    return true
  }
  
  private var canLevelUp: Bool {
    guard level < levels.count else { return false }
    
    return currentLevel.reduce(false) { canLevel, item in
      let practices = allPractices[item] ?? []
      guard practices.count >= MIN_PRACTICE_COUNT else { return false }
      
      return PracticePerformanceService(practices).performance == .Good
    }
  }

  private var allPractices: [Practiceable: [PracticeEntityProtocol]] {
    switch type {
    case .Scale:
      let practices = repo.query(ScalePractice.self)
      return Dictionary(grouping: practices, by: { Practiceable.scale(($0).scale!) })
    case .Interval:
      let practices = repo.query(IntervalPractice.self)
      return Dictionary(grouping: practices, by: { Practiceable.interval(($0).interval!) })
    }
  }
  
  private var levels: [[Practiceable]] {
    switch type {
    case .Scale:
      return TheoryService.scaleLevels
    case .Interval:
      return TheoryService.intervalLevels
    }
  }
}
