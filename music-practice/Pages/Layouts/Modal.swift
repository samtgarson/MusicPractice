//
//  SwiftUIView.swift
//  music-practice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct ModalView<Content: View>: View {
  var title: String?
  var description: String
  var bgColor: Color
  let content: Content
  
  init(title: String? = nil, description: String, bgColor: Color = Colors.success, @ViewBuilder content: () -> Content) {
    self.title = title
    self.bgColor = bgColor
    self.description = description
    self.content = content()
  }
  
  var body: some View {
    PageView(alignment: .center) {
      VStack(spacing: 0) {
        HeaderContent(title: title, description: description)
          .padding(Spacing.medium)
          .background(Color.white)
        lowerHalf
      }
      .cornerRadius(CornerRadius)
      .frame(maxWidth: 500)
    }.withoutScroll
  }
  
  private var lowerHalf: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      content.frame(maxWidth: .infinity, alignment: .leading)
    }
    .foregroundColor(Color.white)
    .padding(Spacing.medium)
    .background(bgColor)
  }
}


struct ModalView_Previews: PreviewProvider {
  static var previews: some View {
    ModalView(description: "Add your first instrument to get started.") {
      Text("Hello world")
      Text("This is a very, very, very, very long piece of text.")
    }
  }
}
