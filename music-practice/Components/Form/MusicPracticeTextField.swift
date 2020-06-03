//
//  MusicPracticeTextField.swift
//  music-practice
//
//  Created by Sam Garson on 03/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct MusicPracticeTextField: View {
  var id: String
  var placeholder: String
  var required: Bool = false
  
  @EnvironmentObject var formState: FormService
  
  var body: some View {
    VStack {
      ZStack(alignment: .leading) {
        if model.wrappedValue.isEmpty { Text(placeholder).opacity(0.75) }
        TextField("", text: model).fixedSize(horizontal: false, vertical: true)
      }
      Rectangle().fill(Color.white).frame(height: 2)
    }
  }
  
  var model: Binding<String> {
    Binding<String>(
      get: { self.formState.get(self.id) ?? "" },
      set: { newValue in self.formState.set(self.id, value: newValue) }
    )
  }
}

struct MusicPracticeTextField_Previews: PreviewProvider {
  
  static var previews: some View {
    ModalView(description: "Test this field") {
      MusicPracticeForm {
        MusicPracticeTextField(id: "test", placeholder: "This is a text field")
      }
    }
  }
}
