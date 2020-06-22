//
//  HomeScreen.swift
//  music-practice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import MusicTheorySwift

struct HomeScreen: View {
  var body: some View {
    Header(title: "Welcome!", description: "What shall we practice today?", performance: .Good) {
      SectionTitle(text: "Next Songs")
      SongsList(showAddSong: .WhenEmpty, filter: .Active, sort: .Performance, limit: 2)
      
      SectionTitle(text: "Next Theory")
        .padding(.top, Spacing.medium)
        .padding(.bottom, Spacing.small)
      TheoryAction(.Scale)
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
