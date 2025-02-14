//
//  WithDefaultStyles.swift
//  MusicPractice
//
//  Created by Sam Garson on 13/02/2025.
//

import SwiftUI

struct DefaultStyles: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(Fonts.body)
      .background(Colors.background.edgesIgnoringSafeArea(.all))
      .foregroundColor(Colors.primary)
  }
}

extension View {
  func withDefaultStyles() -> some View {
    self.modifier(DefaultStyles())
  }
}
