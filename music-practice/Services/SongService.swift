//
//  DataService.swift
//  music-practice
//
//  Created by Sam Garson on 01/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import CoreData
import SwiftUI

public class SongService: BaseService<Song> {
  static let defaultSort = [NSSortDescriptor(key: "createdAt", ascending: true)]
  static let entityName = "Song"
  
  static func all(limit: Int?) -> FetchRequest<Song> {
    let request: NSFetchRequest<Song> = Song.fetchRequest()
    request.sortDescriptors = defaultSort
    request.fetchLimit = limit ?? 0
    return FetchRequest(fetchRequest: request)
  }

  public func create(title: String) {
    guard let context = managedContext else { return }
    
    let newSong = Song(context: context)
    newSong.title = title
    newSong.createdAt = Date()
    save()
  }
}
