//
//  ActivityExpandedContent.swift
//  MusicPractice
//
//  Created by Sam Garson on 24/02/2025.
//

import SwiftUI
import WidgetKit

@DynamicIslandExpandedContentBuilder
func activityDetailExpandedContent(
  practice: InProgressPractice,
  secondsPast: Double
) -> DynamicIslandExpandedContent<some View> {
  DynamicIslandExpandedRegion(.leading) {
    ActivityPracticingPill()
  }
  DynamicIslandExpandedRegion(.trailing) {
    HStack {
      ActivityIcon()
        .frame(width: 20, height: 20)
    }.padding(.trailing, Spacing.small)
  }
  DynamicIslandExpandedRegion(.bottom) {
    VStack(alignment: .leading, spacing: Spacing.tiny) {
      Spacer()
      ActivityTitle(text: practice.practiceable.title)

      ActivityProgressBar(practice: practice, secondsPast: secondsPast)
      Spacer()
    }
  }
}
