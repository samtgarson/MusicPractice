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
  
  @State(initialValue: false) var showSheet
  @State() var selected: Song?
  
  private var fetchRequest: FetchRequest<Song>
  var showAddSong: ShowAddSongState = .WhenEmpty
  var limit: Int?
  var songs: FetchedResults<Song> {
    fetchRequest.wrappedValue
  }
  
  var body: some View {
    MusicPracticeList(collection: songs) { song in
      self.songRow(for: song)
    }
    .withFooter { self.footer }
    .sheet(isPresented: $showSheet, onDismiss: {
      self.selected = nil
    }, content: {
      if self.selected != nil {
        NewSongPracticeScreen(song: self.selected!) {
          self.showSheet = false
        }
      } else {
        NewSongScreen {
          self.showSheet = false
        }
      }
    })
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
  
  private func songRow(for song: Song) -> some View {
    MusicPracticeRow(onTap: {
      self.showSheet = true
      self.selected = song
    }) {
      Unwrap(song.title) { RowLabel($0) }
      Circle().fill(Colors.primary).frame(width: 10, height: 10)
    }
  }
  
  private var footer: some View {
    Group {
      if displayAction {
        MusicPracticeRow(onTap: {
          self.showSheet = true
        }) {
          RowLabel("Add a new song")
          Image(uiImage: Feather.getIcon(.plus)!)
        }
      }
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
