//
//  PracticeService.swift
//  music-practice
//
//  Created by Sam Garson on 01/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import CoreData
import SwiftUI
import MusicTheorySwift

public enum PracticeType: Hashable {
  case song(SongPractice)
  case scale(ScalePractice)
  
  var createdAt: Date {
    switch self {
    case .scale(let practice):
      return practice.createdAt!
    case .song(let practice):
      return practice.createdAt!
    }
  }
  
  var score: Int16 {
    switch self {
    case .scale(let practice):
      return practice.score
    case .song(let practice):
      return practice.score
    }
  }
}

public class PracticeService: BaseService {  
  func createTheoryPractice(_ item: TheoryItem, _ score: Int16) -> PracticeEntityProtocol? {
    guard let context = managedContext else { return nil }
    
    switch item {
    case .scale(let scale):
      let newPractice = instantiate(ScalePractice.self, context)
      newPractice.scale = scale
      newPractice.score = score
      save()
      return newPractice
    }
  }
  
  func createSongPractice(_ song: Song, _ score: Int16) -> SongPractice? {
    guard let context = managedContext else { return nil }
    
    let newPractice = instantiate(SongPractice.self, context)
    newPractice.song = song
    newPractice.score = score
    save()
    
    return newPractice
  }
}
