//
//  SongTests.swift
//  MusicPracticeTests
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
    let practiceable = Practiceable.song(song)
    let p1 = PracticeService().createPractice(practiceable, 1)! as! SongPractice
    let p2 = PracticeService().createPractice(practiceable, 0)! as! SongPractice
    
    XCTAssertEqual(song.practiceArray.count, 2)
    XCTAssertEqual(song.practiceArray[0].objectID, p1.objectID)
    XCTAssertEqual(song.practiceArray[1].objectID, p2.objectID)
  }
}
