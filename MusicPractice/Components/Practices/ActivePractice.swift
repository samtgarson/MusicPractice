//
//  ActivePractice.swift
//  MusicPractice
//
//  Created by Sam Garson on 21/02/2025.
//

import SwiftUI

struct ActivePractice: View {
  var practice: InProgressPractice
  var totalSeconds: Double
  var done: () -> Void
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  let activitySvc: PracticeLiveActivityService

  @State var secondsPast: Double

  init(practice: InProgressPractice, done: @escaping () -> Void) {
    self.practice = practice
    self.activitySvc = PracticeLiveActivityService(practice: practice)

    // 2 second buffer for Ready? message
    let totalSeconds = Double(practice.minutesToPractice * 60 + 2)

    self.totalSeconds = totalSeconds
    self.secondsPast = 0
    self.done = done

    scheduleNotification(in: self.secondsPast)
    activitySvc.start()
  }

  var body: some View {
    Countdown(
      totalSeconds: totalSeconds,
      secondsPast: $secondsPast,
      done: self.finish
    )
      .onReceive(timer) { _ in
        withAnimation {
          self.secondsPast = practice.secondsPast()
        }
        Task { await activitySvc.update() }
      }
  }

  private func scheduleNotification(in seconds: Double) {
    guard NotificationSettings().practiceTimer else { return }
    NotificationService().schedule(
      in: seconds,
      title: "⏲ Time's up!",
      body: "Report back to let me know how your practice went."
    )
  }

  func finish () {
    Task {
      NotificationService().cancelAll()
      self.timer.upstream.connect().cancel()
      await activitySvc.finish()
      self.done()
    }
  }
}

#Preview {
  ActivePractice(
    practice: InProgressPractice(
      practiceable: .interval(.P5),
      startedAt: .now,
      minutesToPractice: 2
    ),
    done: { print("Done") }
  ).padding(Spacing.small)
}
