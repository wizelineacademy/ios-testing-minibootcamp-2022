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


  private func setupView() {
    DispatchQueue.main.async { [weak self] in
      guard let selfView: UserProfileViewController = self,
            let backgroundColorString: String = selfView.viewModel?.userProfile?.backgroundColor else { return }
      selfView.view.backgroundColor = UIColor(hex: backgroundColorString)
      selfView.name.text = selfView.viewModel?.userProfile?.name
      selfView.nickName.text = selfView.viewModel?.userProfile?.nickname
      selfView.userDescription.text = "\(selfView.viewModel?.userProfile?.description ?? "")"
      selfView.location.text = "\(selfView.viewModel?.userProfile?.location ?? "")"
      guard let followers: String = selfView.viewModel?.userProfile?.followers else { return }
      selfView.followers.text = "Followers: \(followers)"
      selfView.creation.text = "\(selfView.viewModel?.userProfile?.creation ?? "")"

      @UsesLayout var coverImage: UIImageView = create {
        guard let coverImageData: Data = selfView.viewModel?.userProfile?.coverImageData else { return }
        $0.image = UIImage(data: coverImageData)
        $0.heightAnchor.constraint(equalToConstant: selfView.view.frame.height * 1/3).isActive = true
      }
      @UsesLayout var profileImageContainer: UIImageView = UIImageView()
      @UsesLayout var profileImage: UIImageView = create {
        guard let profileImageData: Data = selfView.viewModel?.userProfile?.profileImageData else { return }
        $0.image = UIImage(data: profileImageData)?.withRenderingMode(.automatic)
        $0.sizeToFit()
        $0.backgroundColor = .clear
      }

      selfView.view.addSubview(selfView.stackView)
      selfView.stackView.anchor(top: selfView.view.topAnchor, leading: selfView.view.leadingAnchor, trailing: selfView.view.trailingAnchor, bottom: selfView.view.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
      selfView.stackView.backgroundColor = UIColor(hex: backgroundColorString)
      selfView.stackView.distribution = .fill
      selfView.stackView.axis = .vertical
      let subviews: [UIView] = [coverImage, profileImageContainer, selfView.name,
                                selfView.nickName, selfView.userDescription, selfView.location, selfView.followers, selfView.creation, UIView()]
      for subview in subviews {
        selfView.stackView.addArrangedSubview(subview)
      }
      profileImageContainer.addSubview(profileImage)
      profileImage.anchor(top: profileImageContainer.topAnchor, leading: nil, trailing: nil, bottom: profileImageContainer.bottomAnchor, size: CGSize(width: 128, height: 128))

      selfView.view.removeBluerLoader()
    }
  }

  private func getUserProfile() {
    viewModel?.state.bind { [weak self] state in
      guard let state: TweetState = state else { return }
        switch state {
        case .loading:
          self?.view.showBlurLoader()
        case .failure:
          self?.showAlert()
        case .success:
          self?.setupView()
      }
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
