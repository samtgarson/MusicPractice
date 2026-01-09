//
//  HeaderContent.swift
//  MusicPractice
//
//  Created by Sam Garson on 06/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct HeaderContent: View {
  var title: String?
  var description: String
  var performance: Performance?

  var body: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      Image(icon).padding(.bottom, Spacing.small)
      Unwrap(self.title) { t in Text(t).opacity(Opacity.veryFaded) }
      Text(self.description).fixedSize(horizontal: false, vertical: true)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .foregroundColor(fgColor)
  }

  var icon: ImageResource {
    switch performance {
    case .good:
        .whiteGood
    case .bad:
        .whiteBad
    case .meh:
        .whiteMeh
      default:
        .blueGood
    }
  }

  var fgColor: Color {
    if performance != nil { return Color.white }

    return Colors.primary
  }
}

struct HeaderContent_Previews: PreviewProvider {
  static var previews: some View {
    HeaderContent(
      title: "Hello",
      description: "World"
    ).withDefaultStyles()
  }
}
