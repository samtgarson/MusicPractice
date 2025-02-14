//
//  Seeder.swift
//  MusicPractice
//
//  Created by Sam Garson on 03/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import CoreData
import UIKit
import SwiftUI

#if DEBUG
struct Seeder<Content : View>: View {
  var controls: Bool = true
  var content: Content
  var database: Database
  let repo: ModelRepository

  init(controls: Bool? = nil, _ content: () -> Content) {
    self.controls = controls ?? true
    self.content = content()
    self.database = Database.forTest()
    self.repo = ModelRepository(with: self.database.container)
  }
  
  var body: some View {
    VStack {
      content
      if controls {
        HStack {
          Button(action: { self.seedAllEntities() }) { Text("Seed data") }
          Button(action: { self.clearAllEntities() }) { Text("Clear data") }
        }        
      }
    }
    .modelContainer(database.container)
  }
  
  func seedAllEntities() {
    for i in 1...5 {
      let item = TheoryService.scaleLevels.randomElement()!.first!
      PracticeRepository(modelRepo: repo).createPractice(item, .random(in: -1...1))

      let song = SongRepository(modelRepo: repo).create(title: "Song \(i)")
      if i < 3 {
        PracticeRepository(modelRepo: repo).createPractice(Practiceable.song(song!), .random(in: -1...1))
      }
    }
  }
  
  func clearAllEntities() {
    database.reset()
  }
}
#endif
