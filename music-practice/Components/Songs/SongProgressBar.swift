//
//  SongProgressBar.swift
//  music-practice
//
//  Created by Sam Garson on 10/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct SongProgressBar: View {
  internal init(for performance: Performance) {
    self.performance = performance
  }
  
  var performance: Performance
  
  var body: some View {
    HStack(spacing: 2) {
      ForEach(0..<3) { self.pill($0) }
    }
  }
  
  private func pill(_ i: Int) -> some View {
    RoundedRectangle(cornerRadius: 1)
      .fill(i < limit ? color : Colors.background)
      .frame(width: 3, height: FontSizes.body * 0.9)
  }
  
  private var color: Color {
    performanceColor(for: performance)
  }
  
  private var limit: Int {
    switch performance {
    case .Good:
      return 3
    case .Meh:
      return 2
    case .Bad:
      return 1
    }
  }
}

struct ProgressBar_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      SongProgressBar(for: .Good)
      SongProgressBar(for: .Meh)
      SongProgressBar(for: .Bad)
    }
  }
}
