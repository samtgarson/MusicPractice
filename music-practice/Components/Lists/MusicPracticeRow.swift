//
//  MusicPracticeRow.swift
//  music-practice
//
//  Created by Sam Garson on 02/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct MusicPracticeRow<Icon : View>: View {
  let label: String
  let icon: Icon
  
  init(_ label: String, @ViewBuilder content: () -> Icon) {
    self.label = label
    self.icon = content()
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
  }
}

struct MusicPracticeRow_Previews: PreviewProvider {
  static var previews: some View {
    PageView {
      MusicPracticeRow("This is a row") {
        Circle().fill(Color.red).frame(width: 10, height: 10)
        
      }
    }
  }
}
