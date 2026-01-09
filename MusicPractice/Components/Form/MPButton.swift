//
//  MusicPracticeButton.swift
//  MusicPractice
//
//  Created by Sam Garson on 03/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct MPButton: View {
  internal init(_ label: String? = nil, icon: UIImage? = nil, onTap: (() -> Void)? = nil) {
    self.label = label
    self.iconImage = icon
    self.onTap = onTap
  }

  var label: String?
  var onTap: (() -> Void)?
  var iconImage: UIImage?
  var body: some View {
    Button(action: {
      if let handler = self.onTap { handler() }
    }) {
      HStack {
        if let label = label { Text(label) }
        if let img = iconImage { Icon(img) }
      }
      .padding(.vertical, Spacing.small)
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
}

#Preview {
  func handler () { print("tapped!") }

  return VStack {
    MPButton("Take a picture", icon: Icons.aperture, onTap: handler)
    MPButton("Press me") { handler() }
    MPButton(icon: Icons.repeat)
  }
}
