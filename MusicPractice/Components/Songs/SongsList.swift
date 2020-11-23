//
//  SongsList.swift
//  MusicPractice
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

enum SongSort {
  case CreatedAt
  case Performance
}

struct SongsList: View {
  internal init(
    showAddSong: ShowAddSongState = .WhenEmpty,
    filter: SongFilter = .All,
    sort: SongSort = .CreatedAt,
    limit: Int? = nil
  ) {
    self.showAddSong = showAddSong
    self.limit = limit
    self.sort = sort
    
    switch filter {
    case .All:
      self.fetchRequest = SongService.all()
    case .Active:
      self.fetchRequest = SongService.active()
    case .Archived:
      self.fetchRequest = SongService.archived()
    }
  }
  
  @State(initialValue: false) var showSheet
  
  private var fetchRequest: FetchRequest<Song>
  var showAddSong: ShowAddSongState = .WhenEmpty
  var limit: Int?
  var sort: SongSort
  
  var body: some View {
    MPList(collection: songs) { song in
      SongRow(song: song).transition(.move(edge: .bottom))
    }
    .withFooter { self.footer }
  }
  
  var songs: Array<Song> {
    var songs = Array(fetchRequest.wrappedValue)
    if let limit = limit {
      songs = Array(songs.prefix(limit))
    }

    if sort == .Performance {
      songs = songs.sorted(by: {
        PracticePerformanceService($0.practiceArray).priority > PracticePerformanceService($1.practiceArray).priority
      })
    }
    
    return songs
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

#if DEBUG
struct SongsList_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWrapper()
  }
  
  struct PreviewWrapper: View {
    @State(initialValue: false) var sortByPerformance: Bool
    
    var body: some View {
      Seeder {
        PageView {
          Toggle(isOn: $sortByPerformance, label: {
            Text("Sort by performance?".uppercased()).withSmallFont()
          }).padding(.bottom, 30)
          SongsList(showAddSong: .Always, sort: sortByPerformance ? .Performance : .CreatedAt, limit: 3)
        }
        .withDefaultStyles()
      }
    }
  }
}
#endif
