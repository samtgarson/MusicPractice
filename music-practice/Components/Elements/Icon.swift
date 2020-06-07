//
//  Icon.swift
//  music-practice
//
//  Created by Sam Garson on 06/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import NoveFeatherIcons

struct Icon: View {
  var iconName: Feather.IconName
  var color: Color = Colors.primary
  
  var body: some View {
    Image(uiImage: Feather.getIcon(iconName)!)
      .foregroundColor(color)
  }
}

struct Icon_Previews: PreviewProvider {
  static var previews: some View {
    Icon(iconName: .cloud)
  }
}
