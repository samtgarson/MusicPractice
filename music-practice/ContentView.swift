//
//  ContentView.swift
//  music-practice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationWrapper {
      Main()
        .withDefaultStyles()
    }
  }
}

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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Seeder(controls: false) {
      ContentView()
    }
  }
}
