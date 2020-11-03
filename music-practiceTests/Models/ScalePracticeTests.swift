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
    let practiceable = Practiceable.scale(scale)
    let practice = PracticeService().createPractice(practiceable, 1)! as! ScalePractice
    
    XCTAssertEqual(practice.scale, scale)
    
    practice.scale!.key.accidental = .natural
    
    let expected = Scale(type: .minor, key: Key(type: .b))
    XCTAssertEqual(practice.scale, expected)
  }
}
