//
//  UIFontExtensions.swift
//  MiniBootcamp
//
//  Created by Abner Castro on 04/05/22.
//

import Foundation
import UIKit

extension UIFont {
    enum TweetCellSize: CGFloat {
        case name = 16
        case username = 13
        case content = 12
    }
    
    static func bold(withSize size: TweetCellSize) -> UIFont? {
        UIFont(name: "Helvetica-Bold", size: size.rawValue)
    }
    
    static func normal(withSize size: TweetCellSize) -> UIFont? {
        UIFont(name: "Helvetica", size: size.rawValue)
    }
}
