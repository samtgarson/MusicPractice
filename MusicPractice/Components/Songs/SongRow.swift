//
//  SongRow.swift
//  MusicPractice
//
//  Created by Sam Garson on 07/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct SongRow: View {
  internal init(song: Song) {
    self.song = song
    self.performance = PracticePerformanceService(song.practiceArray).performance
  }
  
  var song: Song
  var performance: Performance
  
  @State(initialValue: false) var showNewPractice
  @State(initialValue: false) var confirmArchive
  
  var body: some View {
    WithDragAction(icon: icon, action: action) {
      row
    }
  }

  func action () {
    if song.archivedAt == nil {
      self.confirmArchive.toggle()
    } else {
      withAnimation { SongRepository().unarchive(song: song) }
    }
  }
  
  private var icon: some View {
    if song.archivedAt == nil {
      return Icon(Icons.archive)
    } else {
      return Icon(Icons.cornerRightUp)
    }
  }
  
  private var row: some View {
    MPRow(onTap: { self.showNewPractice.toggle() }) {
      Unwrap(song.title) { RowLabel($0) }
      ProgressBar(for: performance)
    }
    .sheet(isPresented: $showNewPractice) { self.newPracticeScreen }
    .actionSheet(isPresented: $confirmArchive) { self.archiveSheet }
  }
  
  private var archiveSheet: ActionSheet {
    ActionSheet(
      title: Text("Archive \(song.title)?"),
      buttons: [
        .default(Text("Archive it")) { withAnimation { SongRepository().archive(song: self.song) } },
        .cancel(Text("Never mind"))
      ]
    )
  }
  
  private var newPracticeScreen: some View {
    NewPracticeScreen(item: Practiceable.song(self.song)) { self.showNewPractice = false }
  }
}

#if DEBUG
struct SongRow_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWrapper()
  }
  
  struct PreviewWrapper: View {
    var body: some View {
      Seeder {
        PageView { SongsList(showAddSong: .Never, limit: 3) }
          .withDefaultStyles()
      }
    }
  }
}
#endif
