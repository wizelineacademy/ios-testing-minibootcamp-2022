//
//  iOSViewControllerFactory.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 07/04/22.
//

import Foundation
import UIKit

class iOSViewControllerFactory: ViewControllerFactory {
  
  func feedViewController() -> UIViewController {
    FeedViewController()
  }
  
  func composeTweetViewController() -> UIViewController {
    ComposeTweetViewController()
  }

  func getUserProfile() -> UIViewController {
    let api = UserProfileAPI(session: .shared)
    let viewModel = UserProfileViewModel(api: api)
    let view = UserProfileViewController()
    view.viewModel = viewModel
    return view
  }
  
}
