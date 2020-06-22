//
//  Seeder.swift
//  music-practice
//
//  Created by Sam Garson on 03/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

#if DEBUG
import CoreData
import UIKit
import SwiftUI

extension NSManagedObjectContext {
  
  /// Executes the given `NSBatchDeleteRequest` and directly merges the changes to bring the given managed object context up to date.
  ///
  /// - Parameter batchDeleteRequest: The `NSBatchDeleteRequest` to execute.
  /// - Throws: An error if anything went wrong executing the batch deletion.
  public func executeAndMergeChanges(using batchDeleteRequest: NSBatchDeleteRequest) throws {
    batchDeleteRequest.resultType = .resultTypeObjectIDs
    let result = try execute(batchDeleteRequest) as? NSBatchDeleteResult
    let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]
    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [self])
  }
}

struct Seeder<Content : View>: View {
  var context: NSManagedObjectContext
  var controls: Bool = true
  var content: Content
  
  init(controls: Bool? = nil, _ content: () -> Content) {
    self.controls = controls ?? true
    self.content = content()
    self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
    .environment(\.managedObjectContext, context)
  }
  
  func seedAllEntities() {
    for i in 1...5 {
      let item = TheoryService.scaleLevels.randomElement()!.first!
      _ = PracticeService().createPractice(item, Int16.random(in: -1...1))
      
      let song = SongService().create(title: "Song \(i)")
      if i < 3 {
        _ = PracticeService().createPractice(Practiceable.song(song!), Int16.random(in: -1...1))
      }
    }
  }
  
  func clearAllEntities() {
    RequestFactory.destroyEverything()
  }
}
#endif
