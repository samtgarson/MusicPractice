//
//  PracticeLog.swift
//  MusicPractice
//
//  Created by Sam Garson on 06/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct PracticeLog: View {  
  var body: some View {
    ChildView(key: "PracticeLog", title: "Practice Log") {
      PracticesList()
    }
  }
}

#if DEBUG
struct PracticeLog_Previews: PreviewProvider {
  static var previews: some View {
    Seeder {
      NavigationView {
        PracticeLog()
      }
    }
  }
}
#endif
