//
//  ScaleList.swift
//  music-practice
//
//  Created by Sam Garson on 14/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import MusicTheorySwift

struct TheoryProgressScreen: View {
  var type: TheoryType
  
  @FetchRequest(fetchRequest: RequestFactory.raw(ScalePractice.self)) var scalePractices: FetchedResults<ScalePractice>
  
  init(type: TheoryType) {
    self.type = type
  }
  
  var body: some View {
    ChildView(title: "\(type)s") {
      ForEach(0..<levelCount) { level in
        Group {
          self.title(for: level)
          MPList(collection: self.level(for: level)) {
            self.row(for: $0, locked: self.locked(level))
          }
        }.opacity(self.locked(level) ? Opacity.VeryFaded : 1)
      }
    }
  }
  
  private func title(for level: Int) -> some View {
    SectionTitle(
      text: "Level \(level + 1)",
      icon: self.locked(level) ? Icon(iconName: .lock, scale: .small) : nil
    )
    .padding(.top, Spacing.small)
    .padding(.bottom, Spacing.tiny)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private func level(for index: Int) -> [Practiceable] {
    TheoryService.scaleLevels[index]
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
    default:
      return .Good
    }
  }
  
  private var currentLevel: Int {
    TheoryService(type).level
  }
  
  private let levelCount = TheoryService.scaleLevels.count
}

struct TheoryProgressScreen_Previews: PreviewProvider {
  static var previews: some View {
    Seeder {
      TheoryProgressScreen(type: .Scale)
    }
  }
}
