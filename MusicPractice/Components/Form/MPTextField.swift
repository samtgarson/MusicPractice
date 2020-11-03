//
//  MusicPracticeTextField.swift
//  MusicPractice
//
//  Created by Sam Garson on 03/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import NoveFeatherIcons

struct MPTextField: View {
  var id: String
  var placeholder: String
  var required: Bool = false
  
  @EnvironmentObject var formState: FormService
  
  var body: some View {
    VStack {
      HStack {
        ZStack(alignment: .leading) {
          if model.wrappedValue.isEmpty { Text(placeholder).opacity(0.75) }
          TextField("", text: model).fixedSize(horizontal: false, vertical: true)
        }
        if !valid && formState.submitted { validationWarning }
      }
      Rectangle().fill(Color.white).frame(height: 2)
    }.preference(key: FormValidationKey.self, value: self.valid)
  }
  
  var model: Binding<String> {
    Binding<String>(
      get: { self.formState.get(self.id) ?? "" },
      set: { newValue in self.formState.set(self.id, value: newValue) }
    )
  }
  
  var valid: Bool {
    !required || !model.wrappedValue.isEmpty
  }
  
  var validationWarning: some View {
    Image(uiImage: Feather.getIcon(.alertCircle)!)
  }
}

struct MPTextField_Previews: PreviewProvider {
  
  static var previews: some View {
    ModalView(description: "Test this field") {
      MPForm {
        MPTextField(id: "test", placeholder: "This is a text field")
      }
    }
  }
}
