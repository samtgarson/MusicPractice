//
//  ResizeImage.swift
//  music-practice
//
//  Created by Sam Garson on 23/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
  class func resize(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height
    
    var newSize: CGSize
    if widthRatio > heightRatio {
      newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
      newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
  
  class func scale(image: UIImage, by scale: CGFloat) -> UIImage? {
    let size = image.size
    let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
    return UIImage.resize(image: image, targetSize: scaledSize)
  }
}
