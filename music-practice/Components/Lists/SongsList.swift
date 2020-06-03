//
//  SongsList.swift
//  music-practice
//
//  Created by Sam Garson on 02/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import NoveFeatherIcons

enum ShowAddSongState {
  case Always
  case WhenEmpty
  case Never
}

struct SongsList: View {
  internal init(showAddSong: ShowAddSongState = .WhenEmpty, limit: Int? = nil) {
    self.showAddSong = showAddSong
    self.limit = limit
    self.fetchRequest = SongService.all(limit: limit)
  }
  
  var showAddSong: ShowAddSongState = .WhenEmpty
  var limit: Int?
  
  private var fetchRequest: FetchRequest<Song>
  var songs: FetchedResults<Song> {
    fetchRequest.wrappedValue
  }
  
  var body: some View {
    MusicPracticeList(collection: songs, actionRow: actionRow, displayAction: displayAction) { song in
      MusicPracticeRow(song.title!) {
        Circle().fill(Colors.primary).frame(width: 10, height: 10)
      }
    }
  }
  
  private var displayAction: Bool {
    switch showAddSong {
    case .Always:
      return true
    case .Never:
      return false
    case .WhenEmpty:
      return songs.count == 0
    }
  }
  
  private var actionRow: MusicPracticeRow<Image>? {
    MusicPracticeRow("Add a new song") {
      Image(uiImage: Feather.getIcon(.plus)!)
    }
  }
}

struct SongsList_Previews: PreviewProvider {
  static var previews: some View {
    SeedService()
      .seedSongs()
      .render {
        PageView { SongsList(limit: 3) }
      }
  }
}
