//
//  Wrappers.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 16/06/22.
//

import Foundation
import UIKit
@propertyWrapper
public struct UsesLayout<T: UIView> {
  public var wrappedValue: T {
    didSet {
      wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
  }

  public init(wrappedValue: T) {
    self.wrappedValue = wrappedValue
    wrappedValue.translatesAutoresizingMaskIntoConstraints = false
  }
}
