//
//  SongTests.swift
//  MusicPractice
//
//  Created by Sam Garson on 14/02/2025.
//

import Testing
@testable import MusicPractice

final class SongTests: TestSuiteWithDatabase {
  @Test("Song starts with empty practice array")
  func testEmptyPracticeArray() throws {
    let song = SongRepository(modelRepo: repo).create(title: "test song")

    #expect(song?.practiceArray == [])
  }

  @Test("Song can store multiple practices in correct order")
  func testPracticeArrayWithPractices() throws {
    let song = SongRepository(modelRepo: repo).create(title: "test song")!
    let practiceable = Practiceable.song(song)
    let p1 = PracticeRepository(modelRepo: repo).createPractice(practiceable, 1) as! SongPractice
    let p2 = PracticeRepository(modelRepo: repo).createPractice(practiceable, 0) as! SongPractice

    #expect(song.practiceArray.count == 2)
    #expect(song.practiceArray[0] == p1)
    #expect(song.practiceArray[1] == p2)
  }
}
