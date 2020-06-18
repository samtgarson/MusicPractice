//
//  TheoryLabels.swift
//  music-practice
//
//  Created by Sam Garson on 14/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import MusicTheorySwift

struct TheoryLabel: View {
  internal init(_ item: TheoryType) {
    switch item {
    case .scale(let scale):
      self.scale = scale
    }
  }

  var scale: Scale?

  var body: some View {
    Unwrap(scale) { scale in
      self.scaleLabel(scale)
    }
  }

  private func scaleLabel(_ scale: Scale) -> some View {
    HStack(spacing: 2) {
      Text(scale.key.type.description)
        .font(Fonts.sized(FontSizes.large * 1.2))
      Unwrap(scale.key.accidental) { accidental in
        Text(accidental.description)
          .font(Fonts.sized(FontSizes.large * 0.8))
          .padding(.leading, -6)
      }
      Text(scale.type.description.uppercased())
        .font(Fonts.small)
        .kerning(2)
        .fixedSize()
    }
  }
}

struct TheoryLabels_Previews: PreviewProvider {
  static var previews: some View {
    let scale1 = Scale(type: .major, key: .init(type: .g))
    let scale2 = Scale(type: .major, key: .init(type: .g, accidental: .sharp))
    let scale3 = Scale(type: .major, key: .init(type: .b, accidental: .flat))
    return PageView {
      VStack(spacing: Spacing.small) {
        MPRow {
          TheoryLabel(TheoryType.scale(scale1)).frame(maxWidth: .infinity, alignment: .leading)
        }
        MPRow {
          TheoryLabel(TheoryType.scale(scale2)).frame(maxWidth: .infinity, alignment: .leading)
        }
        MPRow {
          TheoryLabel(TheoryType.scale(scale3)).frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }
}
