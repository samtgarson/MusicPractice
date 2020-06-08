//
//  HomeScreen.swift
//  music-practice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {
  var body: some View {
    Header(title: "Welcome!", description: "What shall we practice today?", performance: .Good) {
      SectionTitle(text: "Next Songs")
      SongsList(showAddSong: .WhenEmpty, filter: .Active, limit: 2)
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
