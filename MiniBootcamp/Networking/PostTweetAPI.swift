//
//  PostTweetAPI.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 02/07/22.
//

import Foundation

struct PostTweetAPI {
  let session: URLSession

  func send(_ endpoint: Endpoint, completion: @escaping (Result<Tweet, Error>) -> Void) {
    var request = endpoint.request
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let parameters: [String: Any] = ["Some": "value"]
    request.httpBody = parameters.percentEncoded()
    session.dataTask(with: request) { data, response, error in

      if let error = error {
        debugPrint("error", error)
        completion(.failure(error))
        return
      }

      guard let data = data else {
        completion(.failure(TweetAPIError.noData))
        return
      }
      guard let response = response as? HTTPURLResponse else {
        completion(.failure(TweetAPIError.response))
        return
      }
      guard (200 ... 299) ~= response.statusCode else {
        print("statusCode should be 2xx, but is \(response.statusCode)")
        print("response = \(response)")
        completion(.failure(TweetAPIError.internalServer))
        return
      }

      do {
        let postTweet = try JSONDecoder().decode(Tweet.self, from: data)
        completion(.success(postTweet))
      } catch {
        completion(.failure(TweetAPIError.parsingData))
      }
    }.resume()
  }
}
