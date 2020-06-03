//
//  SectionTitle.swift
//  music-practice
//
//  Created by Sam Garson on 03/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct SectionTitle: View {
  var text: String
  
  var body: some View {
    Text(text.uppercased())
      .font(fontStyle)
      .kerning(2)
      .fixedSize()
  }
  
  var fontStyle = Fonts.small.weight(.medium)
}

struct SectionTitle_Previews: PreviewProvider {
  static var previews: some View {
    PageView {
      SectionTitle(text: "Next Song")
    }
  }
}
