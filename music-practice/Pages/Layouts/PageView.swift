//
//  SwiftUIView.swift
//  music-practice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct PageView<Content: View>: View {
  let content: Content
  var alignment: Alignment
  
  init(alignment: Alignment = .leading, @ViewBuilder content: () -> Content) {
    self.content = content()
    self.alignment = alignment
  }
  
  var body: some View {
    ScrollView {
      main
    }.withDefaultStyles()
  }
  
  private var main: some View {
    VStack(spacing: Spacing.small) {
      self.content
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    .padding(Spacing.medium)
  }
  
  var withoutScroll: some View {
    main
  }
  
  var asChildScreen: some View {
    body
      .navigationBarTitle("")
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)
  }
}

struct PageView_Previews: PreviewProvider {
  static var previews: some View {
    PageView {
      Text("Hello World")
      RoundedRectangle(cornerRadius: CornerRadius).stroke(Colors.primary).frame(height: 1200)
    }
  }
}
