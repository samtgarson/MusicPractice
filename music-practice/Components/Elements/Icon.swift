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
  var scale: CGFloat = 1.0
  
  var body: some View {
    Image(uiImage: uiImage)
  }
  
  private var uiImage: UIImage {
    let color = Colors.ui(self.color)
    let img = Feather.getIcon(iconName)!.withTintColor(color)
    return UIImage.scale(image: img, by: scale)!
  }
  
  private var size: CGFloat {
    24 * scale
  }
}

struct Icon_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Icon(iconName: .cloud)
      Icon(iconName: .moon, color: Colors.success)
      Icon(iconName: .moon, scale: 3)
    }
  }
}
