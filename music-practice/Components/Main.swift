//
//  Main.swift
//  music-practice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import NoveFeatherIcons

enum NavRoute: String {
  case Home
  case Theory
  case Songs
  case Settings
}

struct Main: View {
  @State var selected: NavRoute = .Home
  
  var body: some View {
    VStack(spacing: 0) {
      currentView.frame(maxHeight: .infinity)
      HStack {
        tabItem(NavRoute.Home, .home)
        tabItem(NavRoute.Theory, .bookOpen)
        tabItem(NavRoute.Songs, .music)
        tabItem(NavRoute.Settings, .settings)
      }
      .background(Color.white.edgesIgnoringSafeArea(.bottom))
    }
  }
  
  private var currentView: some View {
    switch selected {
    case .Home:
      return AnyView(HomeScreen())
    case .Theory:
      return AnyView(TheoryScreen())
    case .Songs:
      return AnyView(SongsScreen())
    case .Settings:
      return AnyView(Text("nope"))
    }
  }
  
  private func tabItem (_ route: NavRoute, _ icon: Feather.IconName) -> some View {
    Image(uiImage: Feather.getIcon(icon)!)
      .foregroundColor(Colors.primary)
      .opacity(selected == route ? 1 : 0.3)
      .animation(Animation.easeInOut(duration: 0.15))
      .padding(0)
      .frame(maxWidth: .infinity, maxHeight: 60)
      .onTapGesture {
        self.selected = route
      }
    
    
  }
}

struct Main_Previews: PreviewProvider {
  static var previews: some View {
    Seeder(controls: false) {
      Main().withDefaultStyles()
    }
  }
}
