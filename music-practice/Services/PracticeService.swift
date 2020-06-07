//
//  PracticeService.swift
//  music-practice
//
//  Created by Sam Garson on 01/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import CoreData
import SwiftUI

public enum PracticeValue {
  case song(Song)
}

public enum PracticeType: Hashable {
  case song(SongPractice)
}

public class PracticeService: BaseService {  
  static func songPractices(sort: [NSSortDescriptor]? = defaultSort, limit: Int? = nil) -> FetchRequest<SongPractice> {
    let request: NSFetchRequest<SongPractice> = SongPractice.fetchRequest()
    request.sortDescriptors = sort
    if let limit = limit { request.fetchLimit = limit }
    return FetchRequest(fetchRequest: request)
  }

  public func create(_ value: PracticeValue, _ score: Int16) {
    switch value {
    case .song(let song):
      createSongPractice(song, score)
    }
  }
  
  private func createSongPractice(_ song: Song, _ score: Int16) {
    guard let context = managedContext else { return }
    
    let newPractice = instantiate(SongPractice.self, context)
    newPractice.song = song
    newPractice.score = score
    newPractice.createdAt = Date()
    save()
  }
}
