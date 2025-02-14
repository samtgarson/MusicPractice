//
//  Main.swift
//  MusicPractice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct Main: View {
  @ObservedObject var state = MainNav()

  init() {
    UITabBar.appearance().isTranslucent = false
  }

  var body: some View {
    VStack(spacing: 0) {
      self.currentView
        .environmentObject(state)
      HStack {
        tabItem(NavRoute.Home, Icons.house)
        tabItem(NavRoute.Theory, Icons.bookOpen)
        tabItem(NavRoute.Songs, Icons.music)
        tabItem(NavRoute.Settings, Icons.settings)
      }
      .background(Color.white.edgesIgnoringSafeArea(.bottom))
    }
  }

  private var currentView: some View {
    switch state.selected {
    case .Home:
      return AnyView(HomeScreen())
    case .Theory:
      return AnyView(TheoryScreen())
    case .Songs:
      return AnyView(SongsScreen())
    case .Settings:
      return AnyView(SettingsScreen())
    }
  }

  private func tabItem(_ route: NavRoute, _ icon: UIImage) -> some View {
    Icon(icon, scale: .large)
      .foregroundColor(Colors.primary)
      .opacity(state.selected == route ? 1 : 0.3)
      .animation(Animation.easeInOut(duration: 0.15), value: state.selected)
      .frame(maxWidth: .infinity, maxHeight: 60)
      .onTapGesture {
        self.state.go(to: route)
      }


  }
}

#Preview {
  Seeder(controls: false) {
    NavigationWrapper {
      Main().withDefaultStyles()
    }
  }
}
