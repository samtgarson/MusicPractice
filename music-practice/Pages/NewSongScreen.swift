//
//  NewSongScreen.swift
//  music-practice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

let titleFieldName = "title"

struct NewSongScreen: View {
  @Binding var show: Bool
  
  var body: some View {
    ModalView(title: "Add a new song", description: "What song would you like to practice next?") {
      MusicPracticeForm(buttonLabel: "Save", buttonIcon: .check, onSubmit: { self.createInstrument($0) }) {
        MusicPracticeTextField(id: titleFieldName, placeholder: "Song name", required: true)
      }
    }
  }
  
  func createInstrument(_ model: FormModel) {
    if let title = model[titleFieldName] {
      SongService().create(title: title)
      self.show = false
    }
  }
}

struct NewSongScreen_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWrapper()
  }
  
  struct PreviewWrapper: View {
    @State(initialValue: false) var showScreen
    
    var body: some View {
      Seeder {
        PageView {
          SongsList(showAddSong: .Never)
          Button(action: { self.showScreen.toggle() }) { Text("Show screen") }
        }.sheet(isPresented: $showScreen) {
          NewSongScreen(show: self.$showScreen)
        }
      }
    }
  }
}
