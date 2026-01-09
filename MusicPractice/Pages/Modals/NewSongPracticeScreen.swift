//
//  NewSongScreen.swift
//  MusicPractice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct NewPracticeScreen: View {
  var item: Practiceable
  var hide: () -> Void

  @State(initialValue: false) var timerFinished: Bool

  var body: some View {
    Group {
      if timerFinished {
        newSongScreen
      } else {
        practiceTimer
      }
    }
  }

  private var practiceTimer: some View {
    PracticeTimerScreen(
      practiceable: item,
      done: { self.timerFinished.toggle() }
    )
  }

  private var newSongScreen: some View {
    Header(
      key: "NewPracticeScreen", title: "You practiced \(item.title)",
      description: "Nice work! Practice makes perfect.\n\nHow did it go?"
    ) {
      MPList(collection: PracticeDisplay.items) { display in
        self.practiceOption(for: display)
      }.withFooter {
        self.backButton
      }
    }
  }

  var backButton: some View {
    MPRow(onTap: hide) {
      RowLabel("Never mind")
      Icon(Icons.x)
    }
  }

  func practiceOption(for display: PracticeDisplay) -> some View {
    MPRow(onTap: {
      self.createPractice(display.score)
    }) {
      RowLabel(display.description)
      Icon(display.icon, color: display.iconColor)
    }
  }

  func createPractice(_ score: Int) {
    PracticeRepository().createPractice(item, score)
    analytics.track(goal: AnalyticsGoals.completePractice)
    hide()
  }
}

#Preview {
  @Previewable @State var showScreen: Bool = false

  let song = SongRepository().create(title: "Amazing Grace")

  Seeder {
    PageView {
      Button(action: { showScreen.toggle() }) { Text("Show screen") }
        .padding(.bottom, Spacing.medium)
      PracticesList()
    }
    .sheet(isPresented: $showScreen) {
      NewPracticeScreen(item: Practiceable.song(song!), hide: {
        showScreen = false
      })
    }
    .withDefaultStyles()
  }
}
