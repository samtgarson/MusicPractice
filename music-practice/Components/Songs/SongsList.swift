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

enum SongFilter {
  case All
  case Active
  case Archived
}

struct SongsList: View {
  internal init(showAddSong: ShowAddSongState = .WhenEmpty, filter: SongFilter = .All, limit: Int? = nil) {
    self.showAddSong = showAddSong
    self.limit = limit
    
    switch filter {
    case .All:
      self.fetchRequest = SongService.all(limit: limit)
    case .Active:
      self.fetchRequest = SongService.active(limit: limit)
    case .Archived:
      self.fetchRequest = SongService.archived(limit: limit)
    }
  }
  
  @State(initialValue: false) var showSheet
  
  private var fetchRequest: FetchRequest<Song>
  var showAddSong: ShowAddSongState = .WhenEmpty
  var limit: Int?
  var songs: FetchedResults<Song> {
    fetchRequest.wrappedValue
  }
  
  var body: some View {
    MPList(collection: songs) { song in
      SongRow(song: song).transition(.move(edge: .bottom))
    }
    .withFooter { self.footer }
  }
  
  private var footer: some View {
    Group {
      if displayAction {
        MPRow(onTap: {
          self.showSheet = true
        }) {
          RowLabel("Add a new song")
          Image(uiImage: Feather.getIcon(.plus)!)
        }
        .sheet(isPresented: $showSheet) {
          NewSongScreen { self.showSheet = false }
        }
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
}

struct SongsList_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWrapper()
  }
  
  struct PreviewWrapper: View {
    var body: some View {
      Seeder {
        PageView { SongsList(showAddSong: .Always, limit: 3) }
        .withDefaultStyles()
      }
    }
  }
}
