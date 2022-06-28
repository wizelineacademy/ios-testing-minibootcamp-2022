//
//  UIImageViewExtension.swift
//  MiniBootcamp
//
//  Created by Juan David Torres on 25/06/22.
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
}
