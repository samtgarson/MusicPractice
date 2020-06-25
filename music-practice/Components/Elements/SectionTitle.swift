//
//  SectionTitle.swift
//  music-practice
//
//  Created by Sam Garson on 03/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct SectionTitle: View {
  internal init(text: String, icon: Icon? = nil) {
    self.text = text
    self.icon = icon
  }
  
  var text: String
  var icon: Icon?
  
  var body: some View {
    HStack(alignment: .center) {
      Text(text.uppercased())
        .font(Fonts.small)
        .kerning(WideKerning)
        .fixedSize(horizontal: true, vertical: false)
        .opacity(Opacity.Faded)
      
      Unwrap(icon) { icon in
        Spacer()
        icon
      }
    }
  }
}

struct SectionTitle_Previews: PreviewProvider {
  static var previews: some View {
    PageView {
      SectionTitle(text: "Next Song")
      SectionTitle(text: "Next Song", icon: Icon(iconName: .lifeBuoy))
    }
  }
}
