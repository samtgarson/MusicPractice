//
//  SongTests.swift
//  music-practiceTests
//
//  Created by Sam Garson on 17/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import XCTest
import MusicTheory
@testable import Music_Practice

class ScalePracticeTests: XCTestCase {
  func testScale() throws {
    let scale = Scale(type: .minor, key: Key(type: .b, accidental: .flat))
    let practice = PracticeService().createScalePractice(scale, 1)!
    
    XCTAssertEqual(practice.scale, scale)
    
    practice.scale!.key.accidental = .natural
    
    let expected = Scale(type: .minor, key: Key(type: .b))
    XCTAssertEqual(practice.scale, expected)
  }
}
