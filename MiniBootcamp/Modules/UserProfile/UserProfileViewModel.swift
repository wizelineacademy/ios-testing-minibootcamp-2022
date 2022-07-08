//
//  UserProfileViewModel.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 04/07/22.
//

import Foundation

protocol UserProfileViewModelProtocol {
  var api: UserProfileAPI { get set }
  var state: Observer<TweetState> { get set }
  var userProfile: UserProfile? { get set }
  var error: AlertModel? { get set }
  func downloadUserInfo()
}

class UserProfileViewModel: UserProfileViewModelProtocol {
  var api: UserProfileAPI
  var state: Observer<TweetState> = Observer<TweetState>()
  var userProfile: UserProfile?
  var error: AlertModel?

  init(api: UserProfileAPI) {
    self.api = api
  }


  func downloadUserInfo() {
    state.value = .loading
    api.load(.userProfile, completion: onReceive)
  }

  private func onReceive(_ result: Result<User, Error>) {
    DispatchQueue.main.async {
      switch result {
      case .success(let user):
        self.state.value = .success
        self.userProfile = UserProfile(from: user)
        self.downloadImageData(from: user)
      case .failure(let error):
        self.state.value = .failure
        self.error = self.createAlertModel(error: error)
      }
    }
  }

  private func downloadImageData(from user: User) {
    guard let coverImageURLString = user.coverImageURL,
          let profileImageURLString = user.profileImageURL else { return }
    self.userProfile?.coverImageData = load(urlString: coverImageURLString)
    self.userProfile?.profileImageData = load(urlString: profileImageURLString)

  }

  private func load(urlString: String) -> Data? {
    var data: Data?
    var secureURLString: String = String()
    if !urlString.hasPrefix("https") {
      secureURLString = urlString.replacingOccurrences(of: "http", with: "https")
    }
    let urlString = secureURLString.isEmpty ? urlString : secureURLString

    guard let url: URL = URL(string: urlString) else { return nil }
    data = try? Data(contentsOf: url)
    return data
  }

  private func createAlertModel(error: Error) -> AlertModel {
    return AlertModel(title: "Algo salió mal",
                      message: "Vuelva a intarlo más tarde",
                      buttonTitle: "Aceptar")
  }
}
