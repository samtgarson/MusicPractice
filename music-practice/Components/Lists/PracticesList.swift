//
//  PracticesList.swift
//  music-practice
//
//  Created by Sam Garson on 02/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import NoveFeatherIcons

struct PracticesList: View {
  internal init() {
    self.songPracticeRequest = PracticeService.songPractices()
  }
  
  @State(initialValue: false) var showScreen
  private var songPracticeRequest: FetchRequest<SongPractice>
  var practices: [PracticeType] {
    songPracticeRequest.wrappedValue.map { p in PracticeType.song(p) }
  }
  
  var body: some View {
    VStack {
      MPList(collection: practices) { practice in
        MPRow {
          VStack(spacing: Spacing.small * 0.5) {
            RowLabel(self.label(for: practice))
            RowLabel(self.formatDate(practice)).font(Fonts.small)
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
      Icon(iconName: .coffee)
    }
  }
  
  private func label(for practice: PracticeType) -> String {
    switch practice {
    case .song(let songPractice):
      return songPractice.song?.title ?? "nope"
    }
  }
  
  private func icon(for practice: PracticeType) -> Icon {
    switch practice {
    case .song(let songPractice):
      return PracticeDisplay.with(score: songPractice.score)!.iconImage
    }
  }
  
  private func formatDate(_ practice: PracticeType) -> String {
    switch practice {
    case .song(let songPractice):
      return RelativeDateFormatter(date: songPractice.createdAt!).format()
    }
  }
}

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
