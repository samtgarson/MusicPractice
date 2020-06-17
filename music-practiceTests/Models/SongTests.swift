//
//  SongTests.swift
//  music-practiceTests
//
//  Created by Sam Garson on 17/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import XCTest
@testable import Music_Practice

class SongTests: XCTestCase {
  func testEmptyPracticeArray() throws {
    let song = SongService().create(title: "test song")
    
    XCTAssertEqual(song?.practiceArray, [])
  }
  
  func testPracticeArrayWithPractices() throws {
    let song = SongService().create(title: "test song")!
    let p1 = PracticeService().createSongPractice(song, 1)!
    let p2 = PracticeService().createSongPractice(song, 0)!
    
    XCTAssertEqual(song.practiceArray.count, 2)
    XCTAssertEqual(song.practiceArray.first, p1)
    XCTAssertEqual(song.practiceArray[1], p2)
  }
}
