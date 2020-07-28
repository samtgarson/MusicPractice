//
//  MusicPracticeButton.swift
//  music-practice
//
//  Created by Sam Garson on 03/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import NoveFeatherIcons

struct MPButton: View {
  internal init(_ label: String? = nil, icon: Feather.IconName? = nil, onTap: (() -> Void)? = nil) {
    self.label = label
    self.iconName = icon
    self.onTap = onTap
  }
  
  var label: String?
  var onTap: (() -> Void)?
  var iconName: Feather.IconName?
  var body: some View {
    Button(action: {
      if let handler = self.onTap { handler() }
    }) {
      HStack {
        Unwrap(label) { Text($0) }
        icon
      }
      .padding(.vertical, Spacing.small)
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
  
  var icon: Image? {
    guard let iconName = iconName else { return nil }
    return Image(uiImage: Feather.getIcon(iconName)!)
  }
}

struct MPButton_Previews: PreviewProvider {
  static var previews: some View {
    func handler () { print("tapped!") }

    return ModalView(description: "Testing a button") {
      MPButton("Take a picture", icon: .aperture, onTap: handler)
      MPButton("Press me") { handler() }
      MPButton(icon: .repeatIcon)
    }
  }
}
