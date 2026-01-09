//
//  TheoryLabels.swift
//  MusicPractice
//
//  Created by Sam Garson on 14/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import MusicTheory

struct TheoryLabel: View {
  internal init(_ item: Practiceable) {
    switch item {
    case .scale(let scale):
      self.scale = scale
    case .interval(let interval):
      self.interval = interval
    default:
      break
    }
  }

  var scale: Scale?
  var interval: Interval?

  private let letterSpacing: CGFloat = 8

  var body: some View {
    Group {
      if let scale = scale { self.scaleLabel(scale) }
      if let interval = interval { self.intervalLabel(interval) }
    }
  }

  private func scaleLabel(_ scale: Scale) -> some View {
    HStack(spacing: 0) {
      Text(scale.key.type.description)
        .font(Fonts.sized(FontSizes.large * 1.2))
      Text(scale.key.accidental.description)
          .font(Fonts.sized(FontSizes.large * 0.8))
          .padding(.leading, -1)
      Text(scale.type.description.uppercased())
        .withSmallFont()
        .fixedSize()
        .padding(.leading, letterSpacing)
    }
  }

  private func intervalLabel(_ interval: Interval) -> some View {
    HStack(spacing: 0) {
      if specialIntervals[interval] != nil {
        Text(specialIntervals[interval]!)
          .font(Fonts.sized(FontSizes.body))
      } else {
        Text(interval.quality.description.uppercased())
          .withSmallFont()
          .fixedSize()
        Text("\(interval.degree)")
          .font(Fonts.sized(FontSizes.large * 1.2))
          .padding(.leading, letterSpacing)
          .padding(.trailing, Spacing.tiny)
        Text(formatDegree(interval.degree))
          .withSmallFont()
          .fixedSize()
      }
    }
  }

  func formatDegree(_ degree: Int) -> String {
    let str = NumberFormatter.localizedString(from: NSNumber(value: degree), number: .ordinal)
    return String(str.dropFirst()).uppercased()
  }

  let specialIntervals: [Interval: String] = [.P1: "Unison", .P8: "Octave"]
}

#Preview {
  let scale1 = Scale(type: .major, key: .init(type: .g))
  let scale2 = Scale(type: .major, key: .init(type: .g, accidental: .sharp))
  let scale3 = Scale(type: .major, key: .init(type: .b, accidental: .flat))


  VStack(spacing: Spacing.small) {
    TheoryLabel(Practiceable.scale(scale1)).frame(maxWidth: .infinity, alignment: .leading)

    TheoryLabel(Practiceable.scale(scale2)).frame(maxWidth: .infinity, alignment: .leading)

    TheoryLabel(Practiceable.scale(scale3)).frame(maxWidth: .infinity, alignment: .leading)

    TheoryLabel(Practiceable.interval(.P5)).frame(maxWidth: .infinity, alignment: .leading)

    TheoryLabel(Practiceable.interval(.P8)).frame(maxWidth: .infinity, alignment: .leading)

    TheoryLabel(Practiceable.interval(.P1)).frame(maxWidth: .infinity, alignment: .leading)

  }.padding()
}
