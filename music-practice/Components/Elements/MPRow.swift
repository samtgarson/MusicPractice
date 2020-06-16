//
//  MusicPracticeRow.swift
//  music-practice
//
//  Created by Sam Garson on 02/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import NoveFeatherIcons

struct RowLabel: View {
  var text: String
  
  init(_ text: String) {
    self.text = text
  }
  
  var body: some View {
    Text(text)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct MPRow<Content : View>: View {
  var content: Content
  var tapHandler: (() -> Void)?
  
  init(onTap: (() -> Void)? = nil, @ViewBuilder content: () -> Content) {
    self.content = content()
    self.tapHandler = onTap
  }
  
  var body: some View {
    HStack {
      content
    }
    .padding(Spacing.small)
    .background(Color.white)
    .cornerRadius(CornerRadius)
    .onTapGesture {
      if let handler = self.tapHandler { handler() }
    }
  }
}

struct MPRow_Previews: PreviewProvider {
  static var previews: some View {
    PageView {
      MPRow(onTap: { print("tapped") }) {
        RowLabel("This is a row")
        Circle().fill(Color.red).frame(width: 10, height: 10)
      }
    }
  }
}
