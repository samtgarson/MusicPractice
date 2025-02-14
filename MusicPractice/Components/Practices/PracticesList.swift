//
//  PracticesList.swift
//  MusicPractice
//
//  Created by Sam Garson on 02/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import SwiftData

struct PracticesList: View {
  @State(initialValue: false) var showScreen
//  @FetchRequest(fetchRequest: RequestFactory.raw(SongPractice.self)) var songPractices: FetchedResults<SongPractice>
//  @FetchRequest(fetchRequest: RequestFactory.raw(ScalePractice.self)) var scalePractices: FetchedResults<ScalePractice>
  @Query var songPractices: [SongPractice] = []
  @Query var scalePractices: [ScalePractice] = []

  var practices: [PracticeType] {
    var practices = [PracticeType]()
    practices += songPractices.map { p in PracticeType.song(p) }
    practices += scalePractices.map { p in PracticeType.scale(p) }
    return practices.sorted(by: { $0.createdAt > $1.createdAt })
  }
  
  var body: some View {
    VStack {
      MPList(collection: practices) { practice in
        MPRow {
          VStack(spacing: Spacing.small * 0.5) {
            self.label(for: practice)
            RowLabel(self.formatDate(practice)).font(Fonts.small.weight(.light))
          }
          self.icon(for: practice)
        }
      }
      if practices.isEmpty { emptyMessage }
    }
  }
  
  private var emptyMessage: some View {
    HStack {
      RowLabel("Go practice a song or some theory!")
      Spacer().frame(width: Spacing.medium)
      Icon(Icons.coffee)
    }
  }
  
  private func label(for practice: PracticeType) -> some View {
    switch practice {
    case .song(let songPractice):
      return RowLabel(songPractice.song.title)
    case .scale(let scalePractice):
      return RowLabel(scalePractice.scale!.shortDescription)
    }
  }
  
  private func icon(for practice: PracticeType) -> Icon {
    PracticeDisplay.with(score: practice.score).iconImage
  }
  
  private func formatDate(_ practice: PracticeType) -> String {
    RelativeDateFormatter(date: practice.createdAt).format()
  }
}

#if DEBUG
struct PracticesList_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWrapper()
  }
  
  struct PreviewWrapper: View {
    var body: some View {
      Seeder {
        PageView { PracticesList() }
        .withDefaultStyles()
      }
    }
  }
}
#endif
