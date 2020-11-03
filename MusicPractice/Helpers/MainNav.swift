//
//  MainNav.swift
//  MusicPractice
//
//  Created by Sam Garson on 22/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

enum NavRoute: String {
  case Home
  case Theory
  case Songs
  case Settings
}

class MainNav: ObservableObject {
  @Published var selected: NavRoute = .Home
  
  func go(to target: NavRoute) {
    selected = target
  }
}
