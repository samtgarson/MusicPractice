//
//  MusicPracticeForm.swift
//  music-practice
//
//  Created by Sam Garson on 03/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct MPForm<Fields: View>: View {
  var buttonLabel: String = "Let's go"
  var buttonIcon: UIImage?
  var onSubmit: ((FormModel) -> Void)?
  var content: Fields
  @ObservedObject var state = FormService()
  
  internal init(
    buttonLabel: String = "Let's go",
    buttonIcon: UIImage? = nil,
    onSubmit: ((FormModel) -> Void)? = nil,
    @ViewBuilder content: () -> Fields
  ) {
    self.buttonLabel = buttonLabel
    self.buttonIcon = buttonIcon ?? Icons.arrowRight
    self.content = content()
    self.onSubmit = onSubmit
  }
  
  var body: some View {
    VStack(spacing: Spacing.medium) {
      content
        .environmentObject(state)
        .onPreferenceChange(FormValidationKey.self) { self.state.valid = $0 }
      MPButton(buttonLabel, icon: buttonIcon, onTap: self.onTap)
    }
  }
  
  func onTap () {
    guard state.valid else {
      withAnimation {
        state.submitted = true
      }
      return
    }
    
    if let handler = onSubmit { handler(state.model) }
  }
}

struct MPForm_Previews: PreviewProvider {
  static var previews: some View {
    func onSubmit (model: FormModel) { dump(model) }
    
    return ModalView(description: "Test this form") {
      MPForm(buttonIcon: Icons.check, onSubmit: onSubmit) {
        MPTextField(id: "test", placeholder: "This is a text field", required: true)
      }
    }
  }
}
