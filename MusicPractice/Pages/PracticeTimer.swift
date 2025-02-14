//
//  NewSongScreen.swift
//  MusicPractice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct PracticeTimerScreen: View {
  var subject: String
  var done: () -> Void
  
  @State var selectedTime: Int?
  
  var body: some View {
    Header(key: "PracticeTimerScreen", title: copy.title, description: copy.desc) {
      if selectedTime == nil { timerChoice }
      Unwrap($selectedTime.wrappedValue) { time in
        Countdown(minutes: time, done: self.done)
      }
    }
  }
  
  var timerChoice: some View {
    MPList(collection: timers) { display in
      MPRow(onTap: { self.selectedTime = display.mins }) {
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
  
  var backButton: some View {
    MPRow(onTap: done) {
      RowLabel("Never mind")
      Icon(Icons.x)
    }
  }
  
  var copy: (title: String, desc: String) {
    return selectedTime != nil
      ? (title: "Practicing \(subject)", desc: "Put me down and get to it!")
      : (title: "Ready to practice \(subject)", desc: "How long are you practicing for?")
  }
  
  var timers: [TimerDisplay] = [
    .init(mins: 5, mood: .Bad),
    .init(mins: 10, mood: .Meh),
    .init(mins: 20, mood: .Good)
  ]
  
  struct TimerDisplay: Hashable {
    var mins: Int
    var mood: Performance
  }
}

#if DEBUG
struct PracticeTimerScreen_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWrapper()
  }
  
  struct PreviewWrapper: View {
    @State(initialValue: false) var showScreen
    
    var body: some View {
      func done () { self.showScreen = false }
      
      return Seeder {
        PracticeTimerScreen(subject: "Subject", done: done)
          .withDefaultStyles()
      }
    }
  }
}
#endif
