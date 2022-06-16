//
//  UIImageExtension.swift
//  MiniBootcamp
//
//  Created by Abner Castro on 14/06/22.
//

import Foundation
import UIKit

extension UIImage {
  
  enum Identifier: String {
    case comment
    case fav
    case gato
    case ret
    case share
    
  }
  
  convenience init(_ identifier: Identifier) {
    self.init(named: identifier.rawValue)!
  }
  
  func imageResized(to size: CGSize) -> UIImage {
    return UIGraphicsImageRenderer(size: size).image { _ in
      draw(in: CGRect(origin: .zero, size: size))
    }
  }
}
