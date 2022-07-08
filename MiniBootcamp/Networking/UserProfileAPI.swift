//
//  UserProfileAPI.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 04/07/22.
//

import Foundation

struct UserProfileAPI {
  let session: URLSession

  func load(_ endpoint: Endpoint, completion: @escaping (Result<User, Error>) -> ()) {

    let request = endpoint.request
    session.dataTask(with: request) { data, response, error in

      if let error = error {
        completion(.failure(error))
        return
      }

      guard let data = data else {
        completion(.failure(TweetAPIError.noData))
        return
      }

      do {
        let userProfile = try JSONDecoder().decode(User.self, from: data)
        completion(.success(userProfile))

      } catch {
        completion(.failure(TweetAPIError.parsingData))
      }

    }.resume()
  }
}
