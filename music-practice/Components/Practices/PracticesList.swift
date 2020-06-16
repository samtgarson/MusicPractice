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
  @State(initialValue: false) var showScreen
  var songPractices: FetchRequest<SongPractice>
  var scalePractices: FetchRequest<ScalePractice>
  
  init() {
    self.songPractices = PracticeService.songPractices()
    self.scalePractices = PracticeService.scalePractices()
  }

  var practices: [PracticeType] {
    var practices = [PracticeType]()
    practices += songPractices.wrappedValue.map { p in PracticeType.song(p) }
    practices += scalePractices.wrappedValue.map { p in PracticeType.scale(p) }
    return practices.sorted { $0.createdAt > $1.createdAt }
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
      Icon(iconName: .coffee)
    }
  }
  
  private func label(for practice: PracticeType) -> some View {
    switch practice {
    case .song(let songPractice):
      return RowLabel(songPractice.song!.title!)
    case .scale(let scalePractice):
      let key = scalePractice.scale!.key
      let type = scalePractice.scale!.type
      return RowLabel("\(key.description) \(type.description)")
    }
  }
  
  private func icon(for practice: PracticeType) -> Icon {
    PracticeDisplay.with(score: practice.score)!.iconImage
  }
  
  private func formatDate(_ practice: PracticeType) -> String {
    RelativeDateFormatter(date: practice.createdAt).format()
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
