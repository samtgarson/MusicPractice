//
//  MusicPracticeButton.swift
//  music-practice
//
//  Created by Sam Garson on 03/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import NoveFeatherIcons

struct MusicPracticeButton: View {
  internal init(_ label: String, onTap: (() -> Void)?) {
    self.label = label
    self.onTap = onTap
  }
  
  var label: String
  var onTap: (() -> Void)?
  
  var body: some View {
    HStack {
      Text(label)
      Image(uiImage: Feather.getIcon(.chevronRight)!)
    }
    .foregroundColor(.white)
    .frame(maxWidth: .infinity, alignment: .trailing)
    .onTapGesture {
      if let handler = self.onTap { handler() }
    }
  }
}

struct MusicPracticeButton_Previews: PreviewProvider {
  static var previews: some View {
    func handler () { print("tapped!") }
    print("loaded")
    return ModalView(description: "Testing a button") {
      MusicPracticeButton("Press me", onTap: handler)
    }
  }
}
