//
//  SongProgressService.swift
//  music-practice
//
//  Created by Sam Garson on 09/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation

let a: Double = 100

class PracticePerformanceService {
  static let maxDays: Double = 30
  var practices: [PracticeEntityProtocol]
  private var memo: Double?
  
  init(_ practices: [PracticeEntityProtocol]) {
    self.practices = practices
  }
  
  var performance: Performance {
    switch score {
    case 0..<0.3:
      return .Bad
    case 0.3..<0.6:
      return .Meh
    case 0.6...1:
      return .Good
    default:
      return .Good
    }
  }
  
  var score: Double {
    if let memo = self.memo { return memo }
    
    guard practices.count > 0 else { return 1 }
    
    let scores = practices
      .filter(filterPractices)
      .map {
        PracticeWeight(value: normaliseScore($0.score), weight: staleness($0))
      }
    
    self.memo = weightedAverage(scores)
    return self.memo!
  }
  
  func staleness(_ practice: PracticeEntityProtocol) -> Double {
    guard let createdAt = practice.createdAt else { return 1 }
    
    let sincePractice = createdAt.timeIntervalSinceNow
    let daysSincePractce = Double(sincePractice) / 60 / 60 / 24
    let normalised = 1 - (daysSincePractce/PracticePerformanceService.maxDays)
    
    // Exponential backoff
    return (pow(a, normalised) - 1) / (a - 1)
  }
  
  private func filterPractices(_ practice: PracticeEntityProtocol) -> Bool {
    guard let createdAt = practice.createdAt else { return false }
    
    let sincePractice = createdAt.timeIntervalSinceNow
    let daysSincePractce = Double(sincePractice) / 60 / 60 / 24
    return daysSincePractce <= PracticePerformanceService.maxDays
  }
  
  private func normaliseScore(_ score: Int16) -> Double {
    (Double(score) / 2) + 0.5
  }
  
  struct PracticeWeight: WeightAndValue {
    var value: Double
    var weight: Double
  }
}
