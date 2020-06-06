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
  
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  var body: some View {
    ScrollView {
      VStack {
        self.content
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding(.horizontal, Spacing.medium)
    }
  }
}

struct PageView_Previews: PreviewProvider {
  static var previews: some View {
    PageView() {
      Text("Hello World")
      RoundedRectangle(cornerRadius: CornerRadius).stroke(Colors.primary).frame(height: 1200)
    }
  }
}
