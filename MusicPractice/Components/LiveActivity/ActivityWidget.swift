//
//  ActivityWidget.swift
//  MusicPractice
//
//  Created by Sam Garson on 24/02/2025.
//

import SwiftUI

struct ActivityWidget : View {
  var practice: InProgressPractice
  var secondsPast: Double

  var body: some View {
    VStack(alignment: .leading, spacing: Spacing.tiny) {
      HStack {
        ActivityPracticingPill()
        Spacer()
        ActivityIcon().frame(width: 20, height: 20)
      }.opacity(Opacity.slightlyFaded)

      ActivityTitle(text: practice.practiceable.title)

      Spacer()

      ActivityProgressBar(
        practice: practice,
        secondsPast: secondsPast
      )
    }

    .padding(Spacing.small)
    .background(Colors.success)
    .foregroundStyle(.white)
    .withDefaultStyles()
  }
}

#Preview {
    ActivityWidget(
      practice: .init(
        practiceable: .interval(.M6),
        startedAt: .now,
        minutesToPractice: 2
      ),
      secondsPast: 60
    )
}
