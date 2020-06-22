//
//  NotationHelper.swift
//  music-practice
//
//  Created by Sam Garson on 22/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import MusicTheorySwift

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
  
  private let clef = "&"
  private let space = "--"
  private let end = "."
  
  private let dictionary: [String: String] = [
    "C1": "r",
    "C♯1": "rÒ",
    "D♭1": "sã",
    "D1": "s",
    "D♯1": "sÓ",
    "E♭1": "tä",
    "E1": "t",
    "F1": "u",
    "F♯1": "uÕ",
    "G♭1": "væ",
    "G1": "v",
    "G♯1": "vÖ",
    "A♭1": "wç",
    "A1": "w",
    "A♯1": "w×",
    "B♭1": "xè",
    "B1": "x",
    "C♭2": "yé",
    "C2": "y",
    "C♯2": "yÙ",
    "D♭2": "zê",
    "D2": "z",
    "D♯2": "zÚ",
    "E♭2": "{ë",
    "E2": "{",
    "E♯2": "{Û",
    "F2": "|",
    "F♯2": "|Ü",
    "G♭2": "}í",
    "G2": "}",
    "G♯2": "}Ý",
    "A♭2": "~î",
    "A2": "~",
    "A♯2": "~Þ",
    "B♭2": "˜Ā",
    "B2": "˜"
  ]
}
