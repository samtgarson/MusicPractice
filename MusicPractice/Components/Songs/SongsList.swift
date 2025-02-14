//
//  SongsList.swift
//  MusicPractice
//
//  Created by Sam Garson on 02/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import SwiftData

enum ShowAddSongState {
  case Always
  case WhenEmpty
  case Never
}

enum SongSort {
  case CreatedAt
  case Performance
}

struct SongsList: View {
  var showAddSong: ShowAddSongState
  var sort: SongSort

  init(
    showAddSong: ShowAddSongState = .WhenEmpty,
    filter: SongFilter = .All,
    sort: SongSort = .CreatedAt,
    limit: Int? = nil
  ) {
    self.showAddSong = showAddSong
    self.sort = sort
    var descriptor = SongRepository.predicate(for: filter)
    descriptor.fetchLimit = limit
    self._songQuery = Query(descriptor)
  }

  @Query() var songQuery: [Song]

  @State(initialValue: false) var showSheet
  
  var body: some View {
    MPList(collection: songs) { song in
      SongRow(song: song).transition(.move(edge: .bottom))
    }
    .withFooter { self.footer }
  }
  
  var songs: Array<Song> {
    guard sort == .Performance else { return songQuery }

    return songQuery.sorted(by: {
      PracticePerformanceService($0.practiceArray).priority > PracticePerformanceService($1.practiceArray).priority
    })
  }
  
  private var footer: some View {
    Group {
      if displayAction {
        MPRow(onTap: {
          self.showSheet = true
        }) {
          RowLabel("Add a new song")
          Icon(Icons.plus)
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
