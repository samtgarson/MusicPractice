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
  var scale: IconSize = .normal
  
  enum IconSize: CGFloat {
    case small = 0.75
    case normal = 1
    case large = 2
  }
  
  var body: some View {
    Image(uiImage: uiImage)
  }
  
  private var uiImage: UIImage {
    let color = Colors.ui(self.color)
    let img = Feather.getIcon(iconName)!.withTintColor(color)
    return UIImage.scale(image: img, by: scale.rawValue)!
  }
}

struct Icon_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Icon(iconName: .cloud)
      Icon(iconName: .moon, color: Colors.success)
      Icon(iconName: .moon, scale: .large)
    }
  }
}
