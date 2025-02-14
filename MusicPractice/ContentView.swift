//
//  ContentView.swift
//  MusicPractice
//
//  Created by Sam Garson on 12/02/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Query private var items: [Item]

  var body: some View {
    NavigationWrapper {
      Main()
        .withDefaultStyles()
    }.modelContainer(Database.instance.container)
  }
}

#Preview {
  Seeder(controls: false) {
    ContentView()
  }
}
