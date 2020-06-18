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
  static let maxSeconds: Double = 30 * 24 * 60 * 60
  var practices: [PracticeEntityProtocol]
  
  private var _score: Double?
  private var _frequency: Double?
  
  init(_ practices: [PracticeEntityProtocol]) {
    self.practices = practices
      .filter(filterRecentPractices)
      .sorted { $0.createdAt!.compare($1.createdAt!) == .orderedDescending }
  }
  
  /// A combination of average score and frequency, which
  /// can be used to prioritise the next resource to practice
  var priority: Double {
    weightedAverage([
      (value: 1 - averageScore, weight: 0.6),
      (value: 1 - frequency, weight: 0.6),
      (value: 1 - recency, weight: 1)
    ])
  }
  
  /// A representation of the average score using RAG rating
  var performance: Performance {
    switch averageScore {
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
  
  /// A weighted average of recent scorings for this resource
  var averageScore: Double {
    if let memo = self._score { return memo }
    
    guard practices.count > 0 else { return 1 }
    
    let scores = practices
      .map { (value: normaliseScore($0.score), weight: practiceAge($0)) }
    
    self._score = weightedAverage(scores)
    return self._score!
  }
  
  /// A representation of how frequently this resource has been practiced
  var frequency: Double {
    if let memo = self._frequency { return memo }
    
    guard practices.count > 0 else { return 1 }
    
    let scores = practices.enumerated()
      .map { (index, practice) in
        (
          value: practiceDistance(practice.createdAt!, index == 0 ? Date() : practices[index - 1].createdAt!),
          weight: practiceAge(practice)
        )
      }
    
    self._frequency = weightedAverage(scores)
    return self._frequency!
  }
  
  var recency: Double {
    guard let practice = practices.first else { return 0 }
    
    return practiceAge(practice)
  }
  
  internal func practiceDistance(_ currentDate: Date, _ previousDate: Date) -> Double {
    let diff = Double(abs(currentDate.timeIntervalSince(previousDate)))
    let normalised = 1 - (diff / PracticePerformanceService.maxSeconds)
    
    return normalised
  }
  
  internal func practiceAge(_ practice: PracticeEntityProtocol) -> Double {
    adjust(practiceDistance(practice.createdAt!, Date()))
  }
  
  private func adjust(_ val: Double) -> Double {
    // Exponential backoff
    (pow(a, val) - 1) / (a - 1)
  }
  
  private func normaliseScore(_ score: Int16) -> Double {
    (Double(score) / 2) + 0.5
  }
}

private func filterRecentPractices(_ practice: PracticeEntityProtocol) -> Bool {
  guard let createdAt = practice.createdAt else { return false }
  
  let sincePractice = createdAt.timeIntervalSinceNow
  let daysSincePractce = Double(sincePractice)
  return daysSincePractce <= PracticePerformanceService.maxSeconds
}
