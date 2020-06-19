//
//  ScaleList.swift
//  music-practice
//
//  Created by Sam Garson on 14/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import MusicTheorySwift

struct TheoryList: View {
  var type: TheoryType
  private var scalePractices: FetchedResults<ScalePractice>
  
  init(type: TheoryType) {
    self.type = type
    self.scalePractices = RequestFactory.call(ScalePractice.self).wrappedValue
  }
  
  var body: some View {
    VStack {
      ForEach(0..<levelCount) { level in
        self.title(for: level)
        MPList(collection: self.level(for: level)) { self.row(for: $0) }
      }
    }
  }
  
  private func title(for level: Int) -> some View {
    SectionTitle(text: "Level \(level + 1)")
      .padding(.top, Spacing.medium)
      .padding(.bottom, Spacing.small)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private func level(for index: Int) -> [TheoryItem] {
    TheoryService.scaleLevels[index]
  }
  
  private func row(for item: TheoryItem) -> some View {
    MPRow {
      TheoryLabel(item).frame(maxWidth: .infinity, alignment: .leading)
      ProgressBar(for: performance(for: item))
    }
  }
  
  private func performance(for item: TheoryItem) -> Performance {
    switch item {
    case .scale(let scale):
      let practices = scalePractices.filter { $0.scale == scale }
      return PracticePerformanceService(practices).performance
    }
  }
  
  private let levelCount = TheoryService.scaleLevels.count
}

struct ScaleList_Previews: PreviewProvider {
  static var previews: some View {
    Seeder {
      PageView {
        TheoryList(type: .Scale)
      }
    }
  }
}
