//
//  UIColorExtensions.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 07/04/22.
//

import Foundation
import UIKit

extension UIColor {
  static let redMain = UIColor(red: 0.94, green: 0.20, blue: 0.20, alpha: 1.00)

  convenience init(hex: String, alpha: CGFloat = 1.0) {
    var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") { cString.removeFirst() }

    if cString.count != 6 {
      self.init(cgColor: CGColor.init(_colorLiteralRed: 1, green: 1, blue: 1, alpha: 1))
      return
    }

    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: alpha)
  }
}
