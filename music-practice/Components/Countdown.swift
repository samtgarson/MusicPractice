//
//  Timer.swift
//  music-practice
//
//  Created by Sam Garson on 11/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct Countdown: View {
  
  var totalSeconds: Double
  var target: Date
  var done: () -> Void
  
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  let formatter = DateComponentsFormatter()
  
  @State(initialValue: 0) var secondsLeft: Double
  @State(initialValue: false) var started: Bool
  @State(initialValue: 0) var size: CGFloat
  
  internal init(minutes: Int, done: @escaping () -> Void) {
    self.done = done
    self.totalSeconds = Double(minutes * 60) + 2
    self.target = Date().addingTimeInterval(self.totalSeconds)
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [ .minute, .second ]
    formatter.zeroFormattingBehavior = [ .pad ]
    
    self.secondsLeft = self.totalSeconds
    self.updateTime()
    
    scheduleNotification(in: totalSeconds)
  }
  
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
      
      ForEach(0..<180) { i in
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
    .onReceive(self.timer) { _ in self.updateTime() }
  }
  
  private var countdownText: some View {
    VStack(spacing: Spacing.medium) {
      Text(self.started ? self.formattedTime : "Ready?")
        .frame(maxWidth: .infinity)
        .foregroundColor(self.color.fg)
        .font(Fonts.large.weight(.medium))
        .animation(.none)
        .fixedSize(horizontal: true, vertical: false)
      
      Button(action: self.exit) {
        Text("SKIP").font(Fonts.small)
        Icon(iconName: .arrowRight)
      }
    }
  }
  
  private func on(for i: Int) -> Bool {
    return Double(i)/Double(180) < self.progress
  }
  
  private var progress: Double {
    (totalSeconds - secondsLeft) / totalSeconds
  }
  
  private var formattedTime: String {
    formatter.string(from: secondsLeft) ?? ""
  }
  
  private var color: (fg: Color, bg: Color) {
    switch progress {
    case 0.75..<0.95:
      return (bg: Colors.warning, fg: Color.white)
    case 0.95..<1:
      return (bg: Colors.error, fg: Color.white)
    default:
      return (bg: Color.white, fg: Colors.primary)
    }
  }
  
  private func updateTime() {
    if !started { self.started = true }
    
    guard self.secondsLeft >= 0 else {
      self.exit()
      return
    }
    
    withAnimation {
      self.secondsLeft = self.target.timeIntervalSinceNow
    }
  }
  
  private func exit () {
    self.timer.upstream.connect().cancel()
    NotificationService().cancelAll()
    self.done()
  }
  
  private func scheduleNotification(in seconds: Double) {
    NotificationService().schedule(in: seconds, title: "⏲ Time's up!", body: "Report back to let me know how your practice went.")
  }
  
  struct ClockSizeKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
      value = nextValue()
    }
  }
}

struct Timer_Previews: PreviewProvider {
  static var previews: some View {
    PageView {
      Countdown(minutes: 1) { print("done!") }
    }
  }
}
