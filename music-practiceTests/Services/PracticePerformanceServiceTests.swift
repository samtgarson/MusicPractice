//
//  SongProgressServiceTests.swift
//  SongProgressServiceTests
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import XCTest
@testable import Music_Practice

class PracticePerformanceServiceTests: XCTestCase {
  
  func testScoreWithNoPractices() throws {
    let song = SongService().create(title: "Test song")!
    let result = PracticePerformanceService(song.practiceArray).averageScore
    
    XCTAssertEqual(result, 1.0)
  }
  
  func testScoreWithPractices() throws {
    let song = SongService().create(title: "Test song")!
    [-1, -1, -1, -1, -1, 0, 0, 1].forEach { score in
      _ = createPractice(song, score)
    }
    
    let svc = PracticePerformanceService(song.practiceArray)
    
    XCTAssert(compareDoubles(svc.averageScore, 0.249999), "\(svc.averageScore) not equal")
    XCTAssertEqual(svc.performance, Performance.Bad)
  }
  
  func testAge() throws {
    let tests = [
      947: 0.9983019121,
      106479: 0.825896691,
      302595: 0.579938385,
      864185: 0.2074471386
    ]
    let song = SongService().create(title: "Test song")!
    let svc = PracticePerformanceService(song.practiceArray)
    
    for (secs, expected) in tests {
      let practice = createPractice(song, 0, createdAt: Date(timeIntervalSinceNow: Double(secs)))
      
      let result = svc.practiceAge(practice)
      XCTAssert(compareDoubles(result, expected))
    }
  }
  
  func testPriority() throws {
    let song1 = SongService().create(title: "song1")!
    let song2 = SongService().create(title: "song2")!
    
    _ = createPractice(song1, 1, createdAt: Date().advanced(by: -10 * 24 * 3600))
    _ = createPractice(song2, -1, createdAt: Date().advanced(by: -10 * 24 * 3600))
    
    // when frequency is equal, priority should go to lowest avg score
    XCTAssert(PracticePerformanceService(song1.practiceArray).priority < PracticePerformanceService(song2.practiceArray).priority)
    
    _ = createPractice(song2, -1, createdAt: Date().advanced(by: -1 * 24 * 3600))

//     even when avg score is lower, recency should override
    XCTAssert(PracticePerformanceService(song1.practiceArray).priority > PracticePerformanceService(song2.practiceArray).priority)
    
    _ = createPractice(song1, 1, createdAt: Date().advanced(by: -0.5 * 24 * 3600))
    
    XCTAssert(PracticePerformanceService(song1.practiceArray).priority < PracticePerformanceService(song2.practiceArray).priority)
  }
  
  private func createPractice(_ song: Song, _ score: Int16, createdAt: Date = Date()) -> SongPractice {
    let practice = PracticeService().createSongPractice(song, score)!
    practice.createdAt = createdAt
    return practice
  }
  
  private func compareDoubles(_ a: Double, _ b: Double) -> Bool {
    Int(a*10000) == Int(b*10000)
  }
  
}
