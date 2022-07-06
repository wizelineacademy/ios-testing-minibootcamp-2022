//
//  UserProfileViewController.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 04/07/22.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController {
  var viewModel: UserProfileViewModelProtocol = UserProfileViewModel(api: UserProfileAPI(session: .shared))

  convenience init(viewModel: UserProfileViewModelProtocol) {
    self.init()
    self.viewModel = viewModel
  }
  @UsesLayout var someLabel: UILabel = create {
    $0.text = "Jhoa"
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    viewModel.downloadUserInfo()
    getUserProfile()
  }

  private func setupLabel() {
    view.addSubview(someLabel)
    someLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor)
    someLabel.text = viewModel.userProfile?.nickname
  }

  private func getUserProfile() {
    viewModel.state.bind { [weak self] state in
      guard let state: TweetState = state else { return }
      DispatchQueue.main.async {
        switch state {
        case .loading:
          print("Can show loader")
        case .failure:
          print("Can show alert")
        case .success:
          self?.setupLabel()
          self?.view.reloadInputViews()
        }
      }
    }
  }
}
