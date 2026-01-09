//
//  MusicPracticeWidgetExtensionLiveActivity.swift
//  MusicPracticeWidgetExtension
//
//  Created by Sam Garson on 17/02/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MusicPracticeWidgetExtensionLiveActivity: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: MusicPracticeWidgetExtensionAttributes.self) { context in
      ActivityWidget(
        practice: context.attributes.practice,
        secondsPast: context.state.secondsPast
      )
      .activityBackgroundTint(.success)
      .activitySystemActionForegroundColor(.white)
      .task {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { x in
          print("TIMER: \(Date())")
        }
      }

    } dynamicIsland: { context in
      DynamicIsland {
        activityDetailExpandedContent(
          practice: context.attributes.practice,
          secondsPast: context.state.secondsPast
        )
      } compactLeading: {
        ActivityIcon()
          .padding(6)
      } compactTrailing: {
        HStack {
          Spacer()
          if context.attributes.practice.progress(for: context.state.secondsPast) >= 1 {
            Icon(Icons.badgeCheck)
          } else {
            ActivityCountdownText(practice: context.attributes.practice)
          }
        }
      } minimal: {
        ActivityIcon()
          .padding(6)
      }
      .keylineTint(.success)
    }
  }
}

extension MusicPracticeWidgetExtensionAttributes {
  fileprivate static var previewInterval: MusicPracticeWidgetExtensionAttributes {
    MusicPracticeWidgetExtensionAttributes(practice: .init(
      practiceable: .interval(.A6),
      startedAt: .init(timeIntervalSinceNow: -20),
      minutesToPractice: 2
    ))
  }

  fileprivate static var previewSong: MusicPracticeWidgetExtensionAttributes {
    MusicPracticeWidgetExtensionAttributes(practice: .init(
      practiceable: .song(Song(title: "Boogie on Reggae Woman")),
      startedAt: .init(timeIntervalSinceNow: -20),
      minutesToPractice: 2
    ))
  }
}

#Preview("Interval", as: .content, using: MusicPracticeWidgetExtensionAttributes.previewInterval) {
  MusicPracticeWidgetExtensionLiveActivity()
} contentStates: {
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 20)
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 30)
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 120)
}

#Preview("Song", as: .content, using: MusicPracticeWidgetExtensionAttributes.previewSong) {
  MusicPracticeWidgetExtensionLiveActivity()
} contentStates: {
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 0)
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 1)
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 20)
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 22)
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 24)
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 26)
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 28)
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 30)
}

#Preview("Compact", as: .dynamicIsland(.compact), using: MusicPracticeWidgetExtensionAttributes.previewInterval) {
  MusicPracticeWidgetExtensionLiveActivity()
} contentStates: {
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 20)
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 30)
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 120)
}

#Preview("Minimal", as: .dynamicIsland(.minimal), using: MusicPracticeWidgetExtensionAttributes.previewInterval) {
  MusicPracticeWidgetExtensionLiveActivity()
} contentStates: {
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 20)
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 30)
}

#Preview("Expanded", as: .dynamicIsland(.expanded), using: MusicPracticeWidgetExtensionAttributes.previewInterval) {
  MusicPracticeWidgetExtensionLiveActivity()
} contentStates: {
  MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 30)
}
