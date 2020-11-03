//
//  Main.swift
//  MusicPractice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import NoveFeatherIcons

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
        self.tabItem(NavRoute.Home, .home)
        self.tabItem(NavRoute.Theory, .bookOpen)
        self.tabItem(NavRoute.Songs, .music)
        self.tabItem(NavRoute.Settings, .settings)
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
  
  private func tabItem (_ route: NavRoute, _ icon: Feather.IconName) -> some View {
    Image(uiImage: Feather.getIcon(icon)!)
      .foregroundColor(Colors.primary)
      .opacity(state.selected == route ? 1 : 0.3)
      .animation(Animation.easeInOut(duration: 0.15))
      .frame(maxWidth: .infinity, maxHeight: 60)
      .onTapGesture {
        self.state.go(to: route)
      }
    
    
  }
}

struct Main_Previews: PreviewProvider {
  static var previews: some View {
    Seeder(controls: false) {
      NavigationWrapper {
        Main().withDefaultStyles()
      }
    }
  }
}
