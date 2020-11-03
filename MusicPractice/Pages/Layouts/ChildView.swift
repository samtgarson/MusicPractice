//
//  ChildScreen.swift
//  MusicPractice
//
//  Created by Sam Garson on 24/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct ChildView<Content: View>: View {
  private let key: String?
  
  internal init(key: String? = nil, title: String, @ViewBuilder content: () -> Content) {
    self.title = title
    self.content = content()
    self.key = key
  }
  
  var title: String
  var content: Content
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var body: some View {
    PageView(key: key) {
      PageTitle(title, showBack: true, onBack: back)
      content
    }.asChildScreen
  }
  
  private func back() {
    self.presentationMode.wrappedValue.dismiss()
  }
}

struct ChildScreen_Previews: PreviewProvider {
  static var previews: some View {
    ChildView(title: "Test Page") {
      Text("Hello")
    }
  }
}
