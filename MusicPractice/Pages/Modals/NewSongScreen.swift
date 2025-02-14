//
//  NewSongScreen.swift
//  MusicPractice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

let titleFieldName = "title"

struct NewSongScreen: View {
  var hide: () -> Void
  
  var body: some View {
    ModalView(key: "NewSongScreen", title: "Add a new song", description: "What song would you like to practice next?") {
      MPForm(buttonLabel: "Save", buttonIcon: Icons.check, onSubmit: createInstrument) {
        MPTextField(id: titleFieldName, placeholder: "Song name", required: true)
      }
      MPButton("Never mind", icon: Icons.x, onTap: hide).opacity(Opacity.VeryFaded)
    }
  }
  
  func createInstrument(_ model: FormModel) {
    if let title = model[titleFieldName] {
      SongRepository().create(title: title)
      hide()
    }
  }
}

#if DEBUG
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
        }
        .withDefaultStyles()
        .sheet(isPresented: $showScreen) {
          NewSongScreen() { self.showScreen = false }
        }
      }
    }
  }
}
#endif
