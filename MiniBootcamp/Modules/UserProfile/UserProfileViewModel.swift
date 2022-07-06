//
//  UserProfileViewModel.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 04/07/22.
//

import Foundation

class UserProfileViewModel: UserProfileViewModelProtocol {
  var api: UserProfileAPI
  var state: Observer<TweetState> = Observer<TweetState>()
  var userProfile: User?

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
      case .success(let userProfile):
        self.state.value = .success
        self.userProfile = userProfile
      case .failure(let error):
        self.state.value = .failure
        print("error", error)
      }
    }
  }
}

protocol UserProfileViewModelProtocol {
  var api: UserProfileAPI { get set }
  var state: Observer<TweetState> { get set }
  var userProfile: User? { get set }
  func downloadUserInfo()
}
