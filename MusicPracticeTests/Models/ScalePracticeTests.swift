//
//  ScalePracticeTests.swift
//  MusicPractice
//
//  Created by Sam Garson on 14/02/2025.
//

import Testing
import MusicTheory
import SwiftData
@testable import MusicPractice

@MainActor
final class ScalePracticeTests: TestSuiteWithDatabase {
  @Test("Scale practice creates and modifies scales correctly")
  func testScale() throws {
    let scale = Scale(type: .minor, key: Key(type: .b, accidental: .flat))
    let practiceable = Practiceable.scale(scale)
    let practice = PracticeRepository(modelRepo: repo).createPractice(practiceable, 1)! as! ScalePractice

    #expect(practice.scale == scale)

    practice.scale!.key.accidental = .natural

    let expected = Scale(type: .minor, key: Key(type: .b))
    #expect(practice.scale == expected)
  }
}
