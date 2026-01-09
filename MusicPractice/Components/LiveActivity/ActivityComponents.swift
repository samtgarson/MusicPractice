//
//  ActivityPracticingPill.swift
//  MusicPracticeWidgetExtensionExtension
//
//  Created by Sam Garson on 24/02/2025.
//

import SwiftUI

struct ActivityProgressBar: View {
  var practice: InProgressPractice
  var secondsPast: Double

  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      ProgressView(
        timerInterval: practice.startedAt...practice.finishedAt,
        countsDown: false
      )
        .progressViewStyle(TickProgressStyle())
      ActivityCountdownText(practice: practice)
        .font(Fonts.mediumBold)
    }
  }
}

struct ActivityCountdownText: View {
//  var secondsPast: Double
  var practice: InProgressPractice

  var body: some View {
//    Text(formatForCountdown(secondsPast))
//      .contentTransition(.numericText())
    Text(
      timerInterval: practice.finishedAt...practice.startedAt,
      countsDown: false
    )
      .frame(minWidth: 55)
  }
}

struct ActivityPracticingPill: View {
    var body: some View {
      Text("Practicing")
        .withSmallFont()
        .textCase(.uppercase)
        .padding(.vertical, 6)
        .padding(.horizontal, 9)
        .lineLimit(1)
        .scaledToFit()
        .minimumScaleFactor(0.6)
        .background(.white.opacity(0.2), in: Capsule())
    }
}

struct ActivityIcon: View {
  var body: some View {
    Image(.whiteGood)
      .resizable()
      .aspectRatio(contentMode: .fit)
  }
}

struct ActivityTitle: View {
  var text: String

  var body: some View {
    Text(text)
      .font(Fonts.large)
      .lineLimit(2)
      .minimumScaleFactor(0.7)
  }
}

#Preview {
    ActivityPracticingPill()
}
