//
//  NewSongScreen.swift
//  MusicPractice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct PracticeTimerScreen: View {
  var practiceable: Practiceable
  var done: () -> Void

  @State var practice: InProgressPractice?
  @State var secondsRemaining: Int?

  var body: some View {
    Header(
      key: "PracticeTimerScreen",
      title: copy.title,
      description: copy.desc
    ) {
      if practice == nil { timerChoice }
      if let practice = practice {
        ActivePractice(
          practice: practice,
          done: self.done
        )
      }
    }
  }

  var timerChoice: some View {
    MPList(collection: timers) { display in
      MPRow(onTap: { start(display.mins) }) {
        Text("\(display.mins) mins")
        Spacer()
        ProgressBar(for: display.mood, monochrome: true)
      }
    }.withFooter {
      MPRow(onTap: self.done) {
        Text("I practiced it already").frame(maxWidth: .infinity, alignment: .leading)
        Icon(Icons.arrowRight)
      }
    }
  }

  func start(_ mins: Int) {
    self.practice = InProgressPractice(
      practiceable: practiceable,
      startedAt: .now,
      minutesToPractice: mins
    )
  }

  var backButton: some View {
    MPRow(onTap: done) {
      RowLabel("Never mind")
      Icon(Icons.x)
    }
  }

  var copy: (title: String, desc: String) {
    let title = practiceable.title

    if practice != nil {
      return (title: "Practicing \(title)", desc: "Put me down and get to it!")
    } else {
      return (title: "Ready to practice \(title)", desc: "How long are you practicing for?")
    }
  }

  let timers: [TimerDisplay] = [
    .init(mins: 1, mood: .bad),
    .init(mins: 5, mood: .meh),
    .init(mins: 10, mood: .good)
  ]

  struct TimerDisplay: Hashable {
    var mins: Int
    var mood: Performance
  }
}

#Preview {
  @Previewable @State(initialValue: false) var showScreen

  Seeder {
    PracticeTimerScreen(
      practiceable: .interval(.P5),
      done: { showScreen = false }
    )
      .withDefaultStyles()
  }
}
