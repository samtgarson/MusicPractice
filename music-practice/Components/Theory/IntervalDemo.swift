//
//  IntervalDemo.swift
//  music-practice
//
//  Created by Sam Garson on 20/07/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import MusicTheory

struct IntervalDemo: View {
  internal init(interval: Interval) {
    self.interval = interval
  }
  
  var interval: Interval
  @State private var notes: [Pitch] = []
  
  var body: some View {
    VStack(spacing: Spacing.tiny) {
      MPRow {
        RowLabel("\(interval.semitones) semitones")
        Unwrap(alias ) { alias in
          Text("AKA").withSmallFont()
          Text(alias).fixedSize()
        }.opacity(Opacity.Faded)
      }
      MPRow {
        RowLabel(NotationHelper(pitches: notes).render(), alignment: .center)
          .font(Fonts.notes)
          .layoutPriority(2)
        MPButton(icon: .repeatIcon) { self.generateNotes() }
      }
    }
    .asRowWrapper()
    .onAppear { self.generateNotes() }
  }
    
  private func generateNotes () {
    var potentialKeys = TheoryService.allKeys
    if let currentKey = notes.first?.key {
      potentialKeys = potentialKeys.filter { $0 != currentKey }
    }
    
    let key = potentialKeys.randomElement()!
    let direction = Direction.allCases.randomElement()!
    let baseNote = Pitch(key: key, octave: direction.rawValue)
    
    switch direction {
    case .up:
      self.notes = [baseNote, baseNote + interval]
    case .down:
      self.notes = [baseNote, baseNote - interval]
    }
  }
  
  private let aliasedIntervals: [Interval: String] = [
    .P1: "Unison",
    .d5: "Tritone",
    .P8: "Octave"
  ]
  
  private var alias: String? {
    if let alias = aliasedIntervals[interval] { return alias }
    
    let aliases = Interval.all.filter {
      $0.description != interval.description && $0 == interval
    }
    if aliases.isEmpty { return nil }
    
    return aliases.map { $0.description }.joined(separator: ", ")
  }
  
  private enum Direction: Int, CaseIterable {
    case up = 1
    case down = 2
  }
}

struct IntervalDemo_Previews: PreviewProvider {
  static var previews: some View {
    PageView {
      IntervalDemo(interval: .P5)
      IntervalDemo(interval: .m6)
      IntervalDemo(interval: .d5)
      IntervalDemo(interval: .P1)
      IntervalDemo(interval: .P8)
    }
  }
}
