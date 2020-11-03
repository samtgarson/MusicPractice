//
//  SwiftUIView.swift
//  MusicPractice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct PageView<Content: View>: View {
  let content: Content
  let alignment: Alignment
  
  init(key: String? = nil, alignment: Alignment = .leading, @ViewBuilder content: () -> Content) {
    self.content = content()
    self.alignment = alignment
    
    if let key = key { analytics.track(page: key) }
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
