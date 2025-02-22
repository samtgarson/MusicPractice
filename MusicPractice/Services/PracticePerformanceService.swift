//
//  SongProgressService.swift
//  MusicPractice
//
//  Created by Sam Garson on 09/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation

/// The service responsible for calculating the performance
/// given a set of practices using a number of factors.
class PracticePerformanceService {
  static let maxSeconds: Double = 30 * 24 * 60 * 60
  
  /// Converts generic metric to a Performance enum
  /// - Parameter metric: Double between 0 and 1
  /// - Returns: Performance enum
  static func metricToPerformance(_ metric: Double) -> Performance {
    switch metric {
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
  
  var practices: [PracticeEntityProtocol]
  
  private var _score: Double?
  private var _frequency: Double?
  
  /// Constant which defines the steepness of exponential adjustment
  private let a: Double = 100
  
  init(_ practices: [PracticeEntityProtocol]) {
    self.practices = practices
      .filter(filterRecentPractices)
      .sorted { $0.createdAt.compare($1.createdAt) == .orderedDescending }
  }
  
  /// A combination of average score and frequency, which
  /// can be used to prioritise the next resource to practice
  var priority: Double {
    1 - weightedAverage([
      (value: averageScore, weight: 0.6),
      (value: frequency, weight: 0.6),
      (value: recency, weight: 1)
    ])
  }
  
  /// A representation of the average score using RAG rating
  var performance: Performance {
    Self.metricToPerformance(averageScore)
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
          value: practiceDistance(practice.createdAt, index == 0 ? Date() : practices[index - 1].createdAt),
          weight: practiceAge(practice)
        )
      }
    
    self._frequency = weightedAverage(scores)
    return self._frequency!
  }
  
  /// How long ago the most recent practice was, adjusted for staleness
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
    adjust(practiceDistance(practice.createdAt, Date()))
  }
  
  private func adjust(_ val: Double) -> Double {
    // Exponential backoff
    (pow(a, val) - 1) / (a - 1)
  }
  
  private func normaliseScore(_ score: Int) -> Double {
    (Double(score) / 2) + 0.5
  }
}

private func filterRecentPractices(_ practice: PracticeEntityProtocol) -> Bool {
  let sincePractice = practice.createdAt.timeIntervalSinceNow
  let daysSincePractce = Double(sincePractice)
  return daysSincePractce <= PracticePerformanceService.maxSeconds
}
