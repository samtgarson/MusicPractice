//
//  MusicPracticeRow.swift
//  music-practice
//
//  Created by Sam Garson on 02/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct MusicPracticeRow<Icon : View>: View {
  var label: String
  var icon: Icon
  var tapHandler: (() -> Void)?
  
  init(_ label: String, onTap: (() -> Void)? = nil, @ViewBuilder content: () -> Icon) {
    self.label = label
    self.icon = content()
    self.tapHandler = onTap
  }
  
  var body: some View {
    HStack {
      Text(label)
      Spacer()
      icon
    }
    .padding(Spacing.small)
    .background(Color.white)
    .cornerRadius(CornerRadius)
    .onTapGesture {
      if let handler = self.tapHandler { handler() }
    }
  }
}

struct MusicPracticeRow_Previews: PreviewProvider {
  static var previews: some View {
    PageView {
      MusicPracticeRow("This is a row", onTap: { print("tapped") }) {
        Circle().fill(Color.red).frame(width: 10, height: 10)
      }
    }
  }
}
