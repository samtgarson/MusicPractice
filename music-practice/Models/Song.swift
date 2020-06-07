//
//  Song.swift
//  music-practice
//
//  Created by Sam Garson on 06/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import CoreData

//@objc(Song)
//public class Song: NSManagedObject {
//  
//}
//
//extension Song: EntityProtocol {
//  
//  @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
//    return NSFetchRequest<Song>(entityName: "Song")
//  }
//  
//  @NSManaged public var createdAt: Date?
//  @NSManaged public var id: UUID?
//  @NSManaged public var title: String?
//  @NSManaged public var practices: NSSet?
//  
//}
//
//// MARK: Generated accessors for practices
//extension Song {
//  
//  @objc(addPracticesObject:)
//  @NSManaged public func addToPractices(_ value: SongPractice)
//  
//  @objc(removePracticesObject:)
//  @NSManaged public func removeFromPractices(_ value: SongPractice)
//  
//  @objc(addPractices:)
//  @NSManaged public func addToPractices(_ values: NSSet)
//  
//  @objc(removePractices:)
//  @NSManaged public func removeFromPractices(_ values: NSSet)
//  
//}

extension Song: EntityProtocol {
}
