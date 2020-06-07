//
//  HeaderContent.swift
//  music-practice
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
      Image(self.icon).padding(.bottom, Spacing.small)
      Unwrap(self.title) { t in Text(t).opacity(Opacity.VeryFaded) }
      Text(self.description).fixedSize(horizontal: false, vertical: true)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .foregroundColor(self.fgColor)
  }
  
  var icon: String {
    let color = performance != nil ? "White" : "Blue"
    return "\(color)\(performance ?? Performance.Good)"
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
