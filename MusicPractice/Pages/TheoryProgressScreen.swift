//
//  ScaleList.swift
//  MusicPractice
//
//  Created by Sam Garson on 14/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import MusicTheory

struct TheoryProgressScreen: View {
  var type: TheoryType
  
  @FetchRequest(fetchRequest: RequestFactory.raw(ScalePractice.self)) var scalePractices: FetchedResults<ScalePractice>
  
  @FetchRequest(fetchRequest: RequestFactory.raw(IntervalPractice.self)) var intervalPractices: FetchedResults<IntervalPractice>
  
  init(type: TheoryType) {
    self.type = type
  }
  
  var body: some View {
    ChildView(key: "TheoryProgressionScreen", title: "\(type)s") {
      ForEach(0..<levelCount) { level in
        Group {
          self.title(for: level)
          MPList(collection: self.levels[level]) {
            self.row(for: $0, locked: self.locked(level))
          }
        }.opacity(self.locked(level) ? Opacity.VeryFaded : 1)
      }
    }
  }
  
  private func title(for level: Int) -> some View {
    SectionTitle("Level \(level + 1)",
      icon: self.locked(level) ? Icon(iconName: .lock, scale: .small) : nil
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
      return .Good
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
  
  private var levelCount: Int {
    levels.count
  }
}

struct TheoryProgressScreen_Previews: PreviewProvider {
  static var previews: some View {
    Seeder {
      TheoryProgressScreen(type: .Interval)
    }
  }
}
