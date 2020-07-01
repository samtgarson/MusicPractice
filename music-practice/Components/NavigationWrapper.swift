//
//  NavigationWrapper.swift
//  music-practice
//
//  Created by Sam Garson on 07/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct NavigationWrapper<Content: View>: View {
  var content: Content
  
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  var body: some View {
    NavigationView {
      self.content
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    .background(Colors.background.edgesIgnoringSafeArea(.bottom))
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct NavigationWrapper_Previews: PreviewProvider {
  static var previews: some View {
    NavigationWrapper() {
      PageView {
        Text("Hello world")
      }
    }
  }
}
