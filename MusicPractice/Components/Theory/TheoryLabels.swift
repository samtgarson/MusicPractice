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

  var body: some View {
    Group {
      Unwrap(scale) { self.scaleLabel($0) }
      Unwrap(interval) { self.intervalLabel($0) }
    }
  }

  private func scaleLabel(_ scale: Scale) -> some View {
    HStack(spacing: 0) {
      Text(scale.key.type.description)
        .font(Fonts.sized(FontSizes.large * 1.2))
      Unwrap(scale.key.accidental) { accidental in
        Text(accidental.description)
          .font(Fonts.sized(FontSizes.large * 0.8))
          .padding(.leading, -1)
      }
      Text(scale.type.description.uppercased())
        .withSmallFont()
        .fixedSize()
        .padding(.leading, Spacing.small)
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
          .padding(.leading, Spacing.small)
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

struct TheoryLabels_Previews: PreviewProvider {
  static var previews: some View {
    let scale1 = Scale(type: .major, key: .init(type: .g))
    let scale2 = Scale(type: .major, key: .init(type: .g, accidental: .sharp))
    let scale3 = Scale(type: .major, key: .init(type: .b, accidental: .flat))
    return PageView {
      VStack(spacing: Spacing.small) {
        MPRow {
          TheoryLabel(Practiceable.scale(scale1)).frame(maxWidth: .infinity, alignment: .leading)
        }
        MPRow {
          TheoryLabel(Practiceable.scale(scale2)).frame(maxWidth: .infinity, alignment: .leading)
        }
        MPRow {
          TheoryLabel(Practiceable.scale(scale3)).frame(maxWidth: .infinity, alignment: .leading)
        }
        MPRow {
          TheoryLabel(Practiceable.interval(.P5)).frame(maxWidth: .infinity, alignment: .leading)
        }
        MPRow {
          TheoryLabel(Practiceable.interval(.P8)).frame(maxWidth: .infinity, alignment: .leading)
        }
        MPRow {
          TheoryLabel(Practiceable.interval(.P1)).frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }
}
