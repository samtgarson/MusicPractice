//
//  PracticeLog.swift
//  music-practice
//
//  Created by Sam Garson on 06/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct PracticeLog: View {  
  var body: some View {
    PageView {
      HStack {
        PageTitle("Practice Log", showBack: true, onBack: back)
      }
      PracticesList()
    }.asChildScreen
    
  }
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  private func back() {
    self.presentationMode.wrappedValue.dismiss()
  }
}

struct PracticeLog_Previews: PreviewProvider {
  static var previews: some View {
    Seeder {
      NavigationView {
        PracticeLog()
      }
    }
  }
}
