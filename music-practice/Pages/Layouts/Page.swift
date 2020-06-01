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
    ZStack {
      Colors.background.edgesIgnoringSafeArea(.all)
      VStack {
        content
          .foregroundColor(Colors.primary)
          .font(.custom("Inter-Light", size: 19))
      }
    }
  }
}


struct PageView_Previews: PreviewProvider {
  static var previews: some View {
    PageView {
      Text("Hello..")
      Text("World!")
    }
  }
}
