//
//  NotationHelper.swift
//  MusicPractice
//
//  Created by Sam Garson on 22/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import MusicTheory

class NotationHelper {
  internal init(pitches: [Pitch]) {
    self.pitches = pitches
  }
  
  var pitches: [Pitch]
  
  func render() -> String {
    (
      [clef, space] + notes + [space, end]
    ).joined(separator: space)
  }
  
  private var notes: [String] {
    pitches.map { dictionary[$0.description, default: ""] }
  }
  
  private let clef = "--&"
  private let space = "--"
  private let end = "."
  
  private let dictionary: [String: String] = [
    "C1": "r",
    "C♯1": "Òr",
    "D♭1": "ãs",
    "D1": "s",
    "D♯1": "Ós",
    "E♭1": "ät",
    "E1": "t",
    "F1": "u",
    "F♯1": "Õu",
    "G♭1": "æv",
    "G1": "v",
    "G♯1": "Öv",
    "A♭1": "çw",
    "A1": "w",
    "A♯1": "×w",
    "B♭1": "èx",
    "B1": "x",
    "C♭2": "éy",
    "C2": "y",
    "C♯2": "Ùy",
    "D♭2": "êz",
    "D2": "z",
    "D♯2": "Úz",
    "E♭2": "ë{",
    "E2": "{",
    "E♯2": "Û{",
    "F2": "|",
    "F♯2": "Ü|",
    "G♭2": "í}",
    "G2": "}",
    "G♯2": "Ý}",
    "A♭2": "î~",
    "A2": "~",
    "A♯2": "Þ~",
    "B♭2": "Ā˜",
    "B2": "˜"
  ]
}
