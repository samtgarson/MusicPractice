//
//  ScaleList.swift
//  music-practice
//
//  Created by Sam Garson on 14/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import MusicTheorySwift

struct ScaleList: View {
  private var allPractices: FetchedResults<ScalePractice>
  
  init() {
    self.allPractices = PracticeService.scalePractices().wrappedValue
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
  
  private func level(for index: Int) -> [Scale] {
    TheoryService.scaleLevels[index]
  }
  
  private func row(for scale: Scale) -> some View {
    MPRow {
      TheoryLabel(TheoryType.scale(scale)).frame(maxWidth: .infinity, alignment: .leading)
      ProgressBar(for: performance(for: scale))
    }
  }
  
  private func performance(for scale: Scale) -> Performance {
    let practices = allPractices.filter { $0.scale == scale }
    return PracticePerformanceService(practices).performance
  }
  
  private let levelCount = TheoryService.scaleLevels.count
}

struct ScaleList_Previews: PreviewProvider {
  static var previews: some View {
    Seeder {
      PageView {
        ScaleList()
      }
    }
  }
}
