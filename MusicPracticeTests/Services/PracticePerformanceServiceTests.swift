//
//  PracticePerformanceServiceTests.swift
//  MusicPractice
//
//  Created by Sam Garson on 14/02/2025.
//

import Foundation
import Testing
@testable import MusicPractice

final class PracticePerformanceServiceTests: TestSuiteWithDatabase {
  @Test("Default score with no practices is 1.0")
  func testScoreWithNoPractices() throws {
    let song = SongRepository(modelRepo: repo).create(title: "Test song")!
    let result = PracticePerformanceService(song.practiceArray).averageScore

    #expect(result == 1.0)
  }

  @Test("Score calculation with multiple practices")
  func testScoreWithPractices() throws {
    let song = SongRepository(modelRepo: repo).create(title: "Test song")!
    [-1, -1, -1, -1, -1, 0, 0, 1].forEach { score in
      _ = createPractice(song, score)
    }

    let svc = PracticePerformanceService(song.practiceArray)

    compareDoubles(svc.averageScore, 0.25)
    #expect(svc.performance == Performance.bad)
  }

  @Test("Practice age calculation for various time intervals")
  func testAge() throws {
    let tests = [
      947: 0.9983019121,
      106479: 0.825896691,
      302595: 0.579938385,
      864185: 0.2074471386
    ]
    let song = SongRepository(modelRepo: repo).create(title: "Test song")!
    let svc = PracticePerformanceService(song.practiceArray)

    for (secs, expected) in tests {
      let practice = createPractice(song, 0, createdAt: Date(timeIntervalSinceNow: Double(secs)))
      let result = svc.practiceAge(practice)
      compareDoubles(result, expected)
    }
  }

  @Test("Priority calculation based on practice frequency and scores")
  func testPriority() throws {
    let song1 = SongRepository(modelRepo: repo).create(title: "song1")!
    let song2 = SongRepository(modelRepo: repo).create(title: "song2")!

    createPractice(song1, 1, createdAt: Date().advanced(by: -10 * 24 * 3600))
    createPractice(song2, -1, createdAt: Date().advanced(by: -10 * 24 * 3600))

    // when frequency is equal, priority should go to lowest avg score
    #expect(PracticePerformanceService(song1.practiceArray).priority < PracticePerformanceService(song2.practiceArray).priority)

    createPractice(song2, -1, createdAt: Date().advanced(by: -1 * 24 * 3600))

    // even when avg score is lower, recency should override
    #expect(PracticePerformanceService(song1.practiceArray).priority > PracticePerformanceService(song2.practiceArray).priority)

    createPractice(song1, 1, createdAt: Date().advanced(by: -0.5 * 24 * 3600))

    #expect(PracticePerformanceService(song1.practiceArray).priority < PracticePerformanceService(song2.practiceArray).priority)
  }

  @discardableResult
  private func createPractice(_ song: Song, _ score: Int, createdAt: Date = Date()) -> SongPractice {
    let practiceable = Practiceable.song(song)
    let practice = PracticeRepository(modelRepo: repo).createPractice(practiceable, score)! as! SongPractice
    practice.createdAt = createdAt
    return practice
  }

  private func compareDoubles(_ a: Double, _ b: Double) {
    let roundedA = Int(a*10000)
    let roundedB = Int(b*10000)
    #expect(roundedA == roundedB)
  }
}
