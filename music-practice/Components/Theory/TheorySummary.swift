//
//  TheorySummary.swift
//  music-practice
//
//  Created by Sam Garson on 23/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct TheorySummary: View {
  var type: TheoryType
  
  var body: some View {
    VStack(spacing: 0) {
      performanceBar
      buttons
    }
    .cornerRadius(CornerRadius)
    .asRowWrapper()
  }
  
  private var performanceBar: some View {
    HStack {
      Image("White\(performance)")
        .padding(.trailing, Spacing.small)
      Text(copy.uppercased())
        .withSmallFont()
        .foregroundColor(Color.white)
      Spacer()
    }
    .padding(Spacing.small)
    .padding(.vertical, Spacing.tiny)
    .background(Colors.forPerformance(performance))
  }
  
  private var performance: Performance {
    switch type {
    case .Scale:
      return GeneralPerformanceService().scalePerformance ?? .Good
    case .Interval:
      return GeneralPerformanceService().intervalPerformance ?? .Good
    }
  }
  
  private var copy: String {
    switch performance {
    case .Good:
      return "\(type)s are going great"
    case .Meh:
      return "Keep practicing \(type)s"
    case .Bad:
      return "Don't give up on \(type)s"
    }
  }
  
  private var buttons: some View {
    HStack() {
      Spacer()
      NavigationLink(destination: progressScreen) {
        Text("View progress")
          .font(Fonts.sized(FontSizes.body * 0.75))
        Icon(iconName: .arrowRight, scale: .small)
      }
    }
    .padding(Spacing.small)
    .padding(.vertical, Spacing.tiny)
    .background(Color.white)
  }
  
  private var progressScreen: some View {
    return TheoryProgressScreen(type: type)
  }
}

struct TheorySummary_Previews: PreviewProvider {
  static var previews: some View {
    PageView {
      SectionTitle("Testing")
      TheorySummary(type: .Scale)
    }
  }
}
