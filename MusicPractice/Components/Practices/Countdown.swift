//
//  Timer.swift
//  MusicPractice
//
//  Created by Sam Garson on 11/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct Countdown: View {

  var totalSeconds: Double
  @Binding var secondsPast: Double
  var done: () -> Void

  let totalTicks = 180

  @State var started: Bool = false
  @State var size: CGFloat = 0

  var body: some View {
    VStack {
      GeometryReader { geometry in
        self.clock(size: geometry.size.width)
          .preference(key: ClockSizeKey.self, value: geometry.size.width)
      }
      .frame(height: self.size)
      .onPreferenceChange(ClockSizeKey.self) { size in
        self.size = size
      }
    }
  }

  private func clock(size: CGFloat) -> some View {
    ZStack {
      Circle().fill(self.color.bg)
        .allowsHitTesting(false)

      ForEach(0..<totalTicks) { i in
        RoundedRectangle(cornerRadius: 1)
          .fill(self.color.fg)
          .frame(width: 2, height: self.on(for: i) ? 30 : 20)
          .opacity(self.on(for: i) ? 1 : 0.3)
          .offset(x: 0, y: (-size / 2.2) + (self.on(for: i) ? 5 : 0))
          .rotationEffect(.degrees(Double(i * 2)))
          .allowsHitTesting(false)
      }

      self.countdownText
    }
    .frame(width: size, height: size)
    .onChange(of: secondsPast, updateTime)
  }

  private var countdownText: some View {
    VStack(spacing: Spacing.medium) {
      Text(self.started ? self.formattedTime : "Ready?")
        .contentTransition(.numericText())
        .frame(maxWidth: .infinity)
        .font(Fonts.large.weight(.medium))
        .fixedSize(horizontal: true, vertical: false)

      Button(action: self.done) {
        Text("Skip").withSmallFont().textCase(.uppercase)
        Icon(Icons.arrowRight)
      }
    }.foregroundColor(self.color.fg)
  }

  private func on(for i: Int) -> Bool {
    return Double(i)/Double(totalTicks) < self.progress
  }

  private var progress: Double {
    secondsPast / totalSeconds
  }

  private var formattedTime: String {
    formatForCountdown(secondsPast)
  }

  private var color: (fg: Color, bg: Color) {
    switch progress {
    case 0.75..<0.95:
      return (fg: Color.white, bg: Colors.warning)
    case 0.95..<1:
      return (fg: Color.white, bg: Colors.error)
    default:
      return (fg: Colors.primary, bg: Color.white)
    }
  }

  private func updateTime() {
    if !started { self.started = true }

    if secondsPast > totalSeconds {
      self.done()
    }
  }

  struct ClockSizeKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
      value = nextValue()
    }
  }
}

#Preview {
  @Previewable @State var secondsPast: Double = 0
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

  PageView {
    VStack(spacing: 50) {
      Countdown(
        totalSeconds: 120,
        secondsPast: $secondsPast,
        done: { print("done!") }
      )
      Button("Reset") { secondsPast = 0 }
    }
  }
  .onReceive(timer) { _ in
    guard secondsPast <= 120 else { return }
    withAnimation { secondsPast += 1 }
  }
}
