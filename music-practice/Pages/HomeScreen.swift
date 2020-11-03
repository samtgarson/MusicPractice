//
//  HomeScreen.swift
//  music-practice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import MusicTheory

struct HomeScreen: View {
  var body: some View {
    Header(key: "HomeScreen", title: copy.title, description: copy.description, performance: performance ?? .Good) {
      SectionTitle("Next Songs")
      SongsList(showAddSong: .WhenEmpty, filter: .Active, sort: .Performance, limit: 2)
      
      SectionTitle("Next Theory")
        .padding(.top, Spacing.medium)
        .padding(.bottom, Spacing.small)
      TheoryAction(.Scale).padding(.bottom, Spacing.tiny)
      TheoryAction(.Interval)
    }
  }
  
  private var performance: Performance? {
    GeneralPerformanceService().performance
  }
  
  private var copy: (title: String, description: String) {
    switch performance {
    case nil:
      return (title: "Welcome!", description: "Practice a song or some theory to get started.")
    case .Good:
      return (title: "Welcome back!", description: "What shall we practice today?")
    case .Meh:
      return (title: "Welcome back!", description: "It's easier when you're in a routine, practice makes perfect!")
    case .Bad:
      return (title: "Welcome back!", description: "Been a while since you practiced, don't give up!")
    }
  }
}

struct HomeScreen_Previews: PreviewProvider {
  static var previews: some View {
    Seeder {
      HomeScreen()
      .withDefaultStyles()
    }
  }
}
