//
//  SongService.swift
//  music-practice
//
//  Created by Sam Garson on 01/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import CoreData
import SwiftUI

public class SongService: BaseService {  
  static func all(sort: [NSSortDescriptor]? = defaultSort, limit: Int? = nil, _ fn: ((inout NSFetchRequest<Song>) -> Void)? = nil) -> FetchRequest<Song> {
    var request: NSFetchRequest<Song> = Song.fetchRequest()
    request.sortDescriptors = sort
    if let fn = fn { fn(&request) }
    if let limit = limit { request.fetchLimit = limit }
    return FetchRequest(fetchRequest: request)
  }
  
  static func active(limit: Int? = nil) -> FetchRequest<Song> {
    all(limit: limit) { req in
      req.predicate = NSPredicate(format: "archivedAt == nil")
    }
  }
  
  static func archived(limit: Int? = nil) -> FetchRequest<Song> {
    all(limit: limit) { req in
      req.predicate = NSPredicate(format: "archivedAt != nil")
    }
  }

  public func create(title: String) -> Song? {
    guard let context = managedContext else { return nil }
    
    let newSong = instantiate(Song.self, context)
    newSong.title = title
    save()
    return newSong
  }
  
  public func archive(song: Song) {
    song.archivedAt = Date()
    save()
  }
  
  public func unarchive(song: Song) {
    song.archivedAt = nil
    save()
  }
}