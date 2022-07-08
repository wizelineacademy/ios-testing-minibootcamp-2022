//
//  UserProfileViewController.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 04/07/22.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController {
  var viewModel: UserProfileViewModelProtocol?
  var alert: UIAlertController = UIAlertController()

  @UsesLayout var name: UILabel = create {
    $0.textColor = .darkGray
    $0.font = UIFont.bold(withSize: .name)
  }
  @UsesLayout var nickName: UILabel = create {
    $0.textColor = .darkGray
    $0.font = UIFont.normal(withSize: .username)
  }
  @UsesLayout var userDescription: UILabel = create {
    $0.textColor = .darkGray
    $0.font = UIFont.normal(withSize: .content)
  }
  @UsesLayout var location: UILabel = create {
    $0.textColor = .darkGray
    $0.font = UIFont.normal(withSize: .content)
  }
  @UsesLayout var followers: UILabel = create {
    $0.textColor = .darkGray
    $0.font = UIFont.normal(withSize: .content)
  }
  @UsesLayout var creation: UILabel = create {
    $0.textColor = .darkGray
    $0.font = UIFont.normal(withSize: .content)
  }
  @UsesLayout var coverImage: UIImageView = UIImageView()
  @UsesLayout var profileImageContainer: UIImageView = UIImageView()
  @UsesLayout var profileImage: UIImageView = UIImageView()

  convenience init(viewModel: UserProfileViewModelProtocol) {
    self.init()
    self.viewModel = viewModel
  }

  @UsesLayout var stackView: UIStackView = create {
    $0.backgroundColor = .systemCyan
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.showBlurLoader()
    viewModel?.downloadUserInfo()
    DispatchQueue.main.async { [weak self] in
      self?.getUserProfile()
    }
  }

  func fillInformation(userProfile: UserProfile) {
    let followers: String = "Followers: \(userProfile.followers)"
    view.backgroundColor = UIColor(hex: userProfile.backgroundColor)
    stackView.backgroundColor = UIColor(hex: userProfile.backgroundColor)
    name.text = userProfile.name
    nickName.text = userProfile.nickname
    userDescription.text = userProfile.description
    location.text = userProfile.location
    self.followers.text = followers
    creation.text = userProfile.creation
    guard let coverImageData = userProfile.coverImageData else { return }
    coverImage.image = UIImage(data: coverImageData)
    coverImage.heightAnchor.constraint(equalToConstant: view.frame.height * 1/4).isActive = true
    guard let profileImageData: Data = userProfile.profileImageData else { return }
    profileImage.image = UIImage(data: profileImageData)?.withRenderingMode(.automatic)
    profileImage.sizeToFit()
    profileImage.backgroundColor = .clear
  }

  func getUserProfile() {
    viewModel?.state.bind { state in
      guard let state: TweetState = state else { return }
        switch state {
        case .loading:
          self.view.showBlurLoader()
        case .failure:
          self.showAlert()
        case .success:
          DispatchQueue.main.async {
            self.setupView()
          }
      }
    }
  }

  private func setupView() {
    DispatchQueue.main.async { [weak self] in
      guard let selfView: UserProfileViewController = self,
            let userProfile: UserProfile = selfView.viewModel?.userProfile else { return }
      selfView.fillInformation(userProfile: userProfile)

      selfView.view.addSubview(selfView.stackView)
      selfView.stackView.anchor(top: selfView.view.topAnchor, leading: selfView.view.leadingAnchor, trailing: selfView.view.trailingAnchor, bottom: selfView.view.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
      selfView.stackView.distribution = .fill
      selfView.stackView.axis = .vertical
      selfView.stackView.spacing = 8
      let subviews: [UIView] = [selfView.coverImage, selfView.profileImageContainer, selfView.name,
                                selfView.nickName, selfView.userDescription, selfView.location, selfView.followers, selfView.creation, UIView()]
      for subview in subviews {
        selfView.stackView.addArrangedSubview(subview)
      }
      selfView.profileImageContainer.addSubview(selfView.profileImage)
      selfView.profileImage.anchor(top: selfView.profileImageContainer.topAnchor, leading: nil, trailing: nil, bottom: selfView.profileImageContainer.bottomAnchor, size: CGSize(width: 128, height: 128))

      selfView.view.removeBluerLoader()
    }
  }

  private func showAlert() {
    DispatchQueue.main.async { [weak self] in
      self?.alert = UIAlertController(title: self?.viewModel?.error?.title ?? "Fatal error", message: self?.viewModel?.error?.message ?? "App crash", preferredStyle: UIAlertController.Style.alert)
      self?.alert.addAction(UIAlertAction(title: self?.viewModel?.error?.buttonTitle ?? "Accept", style: UIAlertAction.Style.default, handler: { _ in
        self?.navigationController?.popViewController(animated: true)
      }))
      self?.present(self?.alert ?? UIAlertController(), animated: true, completion: nil)
    }
  }
}
