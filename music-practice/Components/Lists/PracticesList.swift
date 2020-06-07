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
    MPList(collection: practices) { practice in
      MPRow {
        RowLabel(self.label(for: practice))
        self.icon(for: practice)
      }
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
