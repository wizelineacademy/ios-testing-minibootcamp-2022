//
//  UINavigationControllerExtensions.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 08/06/22.
//

import UIKit

extension UINavigationController {
  func transparentNavigationBar() {
    self.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationBar.shadowImage = UIImage()
    self.navigationBar.isTranslucent = true
  }

  func setTintColor(_ color: UIColor) {
    self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    self.navigationBar.tintColor = color
  }

  func backgroundColor(_ color: UIColor) {
    navigationBar.setBackgroundImage(nil, for: .default)
    navigationBar.barTintColor = color
    navigationBar.shadowImage = UIImage()
  }
}