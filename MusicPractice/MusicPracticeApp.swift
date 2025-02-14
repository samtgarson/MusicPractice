//
//  MusicPracticeApp.swift
//  MusicPractice
//
//  Created by Sam Garson on 12/02/2025.
//

import SwiftUI
import SwiftData

@main
struct MusicPracticeApp: App {
    var body: some Scene {
        WindowGroup {
          NavigationWrapper {
            Main()
              .withDefaultStyles()
          }
        }
        .modelContainer(Database.instance.container)
    }
}
