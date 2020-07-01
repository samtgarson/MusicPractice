//
//  TheoryScreen.swift
//  music-practice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct SongsScreen: View {
  var body: some View {
    PageView {
      PageTitle("Songs")
      SectionTitle("Active Songs")
      SongsList(showAddSong: .Always, filter: .Active)
        .padding(.bottom, Spacing.small)
      
      CollapsibleSection(title: "Archived Songs") {
        SongsList(showAddSong: .Never, filter: .Archived)
      }
    }
  }
}

struct SongsScreen_Previews: PreviewProvider {
  static var previews: some View {
    Seeder {
      SongsScreen()
    }
  }
}
