//
//  NewSongScreen.swift
//  music-practice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import NoveFeatherIcons

struct NewSongPracticeScreen: View {
  var song: Song
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
    PracticeTimerScreen(subject: song.title!, done: { self.timerFinished.toggle() })
  }
  
  private var newSongScreen: some View {
    Header(title: "You practiced \(song.title!)", description: "Nice work! Practice makes perfect.\n\nHow did it go?") {
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
      Icon(iconName: .x)
    }
  }
  
  
  
  func practiceOption(for display: PracticeDisplay) -> some View {
    MPRow(onTap: {
      self.createPractice(display.score)
    }) {
      RowLabel(display.description)
      Icon(iconName: display.icon, color: display.iconColor)
    }
  }
  
  func createPractice(_ score: Int16) {
    PracticeService().create(.song(song), score)
    hide()
  }
}

struct NewSongPracticeScreen_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWrapper()
  }
  
  struct PreviewWrapper: View {
    @State(initialValue: false) var showScreen
    
    var body: some View {
      let song = SongService().create(title: "Amazing Grace")
      func hide () { self.showScreen = false }
      
      return Seeder {
        PageView {
          Button(action: { self.showScreen.toggle() }) { Text("Show screen") }
            .padding(.bottom, Spacing.medium)
          PracticesList()
        }
        .sheet(isPresented: $showScreen) {
          NewSongPracticeScreen(song: song!, hide: hide)
        }
        .withDefaultStyles()
      }
    }
  }
}
