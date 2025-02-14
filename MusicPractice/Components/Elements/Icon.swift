//
//  Icon.swift
//  MusicPractice
//
//  Created by Sam Garson on 06/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import LucideIcons

public typealias Icons = Lucide

struct Icon: View {
  var icon: UIImage
  var color: Color? = nil
  var scale: IconSize = .normal

  init(_ icon: UIImage, color: Color? = nil, scale: IconSize = .normal) {
    self.icon = icon
    self.color = color
    self.scale = scale
  }

  enum IconSize: CGFloat {
    case small = 0.95
    case normal = 1.2
    case large = 1.5
  }

  var body: some View {
    if let color = color {
      image.foregroundColor(color)
    } else {
      image
    }
  }

  private var image: Image {
    let ui = UIImage.scale(image: icon, by: scale.rawValue)!
    return Image(uiImage: ui).renderingMode(.template)
//    }
//
//    let img = icon.withTintColor(Colors.ui(color))
//    return UIImage.scale(image: img, by: scale.rawValue)!
  }
}

#Preview {
  VStack(spacing: 40) {
    Icon(Icons.aArrowDown)
    Icon(Icons.moon, color: Colors.success)
    VStack {
      Icon(Icons.star, scale: .large)
    }
    .foregroundColor(.white)
    .padding()
    .background(.success)
  }
}

