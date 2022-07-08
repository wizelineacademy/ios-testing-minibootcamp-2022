//
//  CoordinatorStub.swift
//  MiniBootcampTests
//
//  Created by Heber Raziel Alvarez Ruedas on 05/07/22.
//

import UIKit
@testable import MiniBootcamp

class CoordinatorStub: Coordinator {
  var rootViewController: UINavigationController = UINavigationController()
  var calls: [String] = []

  func start() {
    calls.append(#function)
  }

  func composeTweet() {
    calls.append(#function)
  }

  func getUserProfile() {
    calls.append(#function)
  }
}
