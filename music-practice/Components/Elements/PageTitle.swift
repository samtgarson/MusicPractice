//
//  PageTitle.swift
//  music-practice
//
//  Created by Sam Garson on 05/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct PageTitle: View {
  var content: String
  
  init(_ content: String) {
    self.content = content
  }
  
  var body: some View {
    Sticky { _ in
      Text(self.content)
        .font(Fonts.large)
        .padding(.vertical, Spacing.medium)
    }.frame(height: 100)
  }
}

struct PageTitle_Previews: PreviewProvider {
  static var previews: some View {
    PageView() {
      PageTitle("Theory")
      RoundedRectangle(cornerRadius: CornerRadius).stroke(Colors.primary).frame(height: 1200)
    }
  }
}
