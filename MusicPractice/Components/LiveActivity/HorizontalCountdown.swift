//
//  Countdown.swift
//  MusicPracticeWidgetExtensionExtension
//
//  Created by Sam Garson on 23/02/2025.
//

import SwiftUI

struct TickProgressStyle: ProgressViewStyle {
  func makeBody(configuration: Configuration) -> some View {
    return ProgressView(configuration)
      .background(.white)
      .tint(.white)
      .cornerRadius(5)
  }
}


struct HorizontalCountdown: View {
  var totalTicks: Int
  var progress: Double

  static let height: CGFloat = 12

  var body: some View {
    HStack(alignment: .bottom, spacing: 2) {
      ForEach(ticks) { tick in
        RoundedRectangle(cornerRadius: 1)
          .fill(.white)
          .frame(width: 2, height: tick.height)
          .opacity(tick.opacity)
          .allowsHitTesting(false)
      }
    }
  }

  private var ticks: [Tick] {
    (0..<totalTicks).map { i in
      Tick(index: i, totalTicks: totalTicks, progress: progress)
    }
  }

  private struct Tick: Identifiable {
    var id: Int { index }
    var index: Int
    var totalTicks: Int
    var progress: Double

    var on: Bool {
      index <= Int(Double(totalTicks) * progress)
    }

    var height: CGFloat {
      on ? HorizontalCountdown.height : 8
    }

    var opacity: Double {
      on ? 1 : 0.3
    }
  }
}

#Preview {
  VStack {
    HorizontalCountdown(totalTicks: 80, progress: 0.25)
    ProgressView(timerInterval: Date()...Date().addingTimeInterval(60), countsDown: false)
    ProgressView(
      timerInterval: Date()...Date().addingTimeInterval(60),
      countsDown: false,
      label: { EmptyView() },
      currentValueLabel: { EmptyView() }
    )
      .progressViewStyle(TickProgressStyle())
  }.padding().background(Colors.success)
}
