//
//  ScaleList.swift
//  MusicPractice
//
//  Created by Sam Garson on 14/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import MusicTheory
import SwiftData

struct TheoryProgressScreen: View {
  var type: TheoryType
  
  @Query var scalePractices: [ScalePractice]
  @Query var intervalPractices: [IntervalPractice]
  
  init(type: TheoryType) {
    self.type = type
  }
  
  var body: some View {
    ChildView(key: "TheoryProgressionScreen", title: "\(type)s") {
      ForEach(0..<levels.count) { level in
        Group {
          self.title(for: level)
          MPList(collection: self.levels[level]) {
            self.row(for: $0, locked: self.locked(level))
          }
        }.opacity(self.locked(level) ? Opacity.veryFaded : 1)
      }
    }
  }
  
  private func title(for level: Int) -> some View {
    SectionTitle("Level \(level + 1)",
                 icon: self.locked(level) ? Icon(Icons.lock, scale: .small) : nil
    )
    .padding(.top, Spacing.small)
    .padding(.bottom, Spacing.tiny)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private func locked(_ level: Int) -> Bool {
    level > self.currentLevel
  }
  
  private func row(for item: Practiceable, locked: Bool) -> some View {
    return MPRow {
      TheoryLabel(item).frame(maxWidth: .infinity, alignment: .leading)
      if !locked { ProgressBar(for: performance(for: item)) }
    }
  }
  
  private func performance(for item: Practiceable) -> Performance {
    switch item {
    case .scale(let scale):
      let practices = scalePractices.filter { $0.scale == scale }
      return PracticePerformanceService(practices).performance
    case .interval(let interval):
      let practices = intervalPractices.filter { $0.interval == interval }
      return PracticePerformanceService(practices).performance
    default:
      return .good
    }
  }
  
  private var levels: [[Practiceable]] {
    switch type {
    case .Interval:
      return TheoryService.intervalLevels
    case .Scale:
      return TheoryService.scaleLevels
    }
  }
  
  private var currentLevel: Int {
    TheoryService(type).level
  }
  
}

#Preview {
  Seeder {
    TheoryProgressScreen(type: .Interval)
  }
}
