//
//  Endpoint.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 07/04/22.
//

import Foundation

enum Endpoint {
  static let baseURL = "https://wizetwitterproxy.herokuapp.com"

  case timeline
  case postTweet
}

extension Endpoint {
    var string: String {
        switch self {
        case .timeline:
            return "/api/statuses/user_timeline"
        case .postTweet:
          return "/api/statuses/update"
        }
    }
    
  var request: URLRequest {
    switch self {
    case .timeline:
      let url = URL(string: Endpoint.baseURL + string)!
      return URLRequest(url: url)
    case .postTweet:
      let url = URL(string: Endpoint.baseURL + string)!
      return URLRequest(url: url)
    }
  }
}

/*
struct PostTweetApi {
  func postTweet() {
    let url = URL(string: "https://wizetwitterproxy.herokuapp.com/api/statuses/update")!
    var request = URLRequest(url: url)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "POST"
    let parameters: [String: Any] = ["Some": "value"]
    request.httpBody = parameters.percentEncoded()

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard
        let data = data,
        let response = response as? HTTPURLResponse,
        error == nil
      else {                                                               // check for fundamental networking error
        print("error", error ?? URLError(.badServerResponse))
        return
      }

      guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
        print("statusCode should be 2xx, but is \(response.statusCode)")
        print("response = \(response)")
        return
      }

      // do whatever you want with the `data`, e.g.:

      do {
        let responseObject = try JSONDecoder().decode(ResponseObject.self, from: data)
        print(responseObject)
      } catch {
        print(error) // parsing error

        if let responseString = String(data: data, encoding: .utf8) {
          print("responseString = \(responseString)")
        } else {
          print("unable to parse response as string")
        }
      }
    }

    task.resume()

  }
}
*/

extension Dictionary {
  func percentEncoded() -> Data? {
    map { key, value in
      let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
      let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
      return escapedKey + "=" + escapedValue
    }
    .joined(separator: "&")
    .data(using: .utf8)
  }
}

extension CharacterSet {
  static let urlQueryValueAllowed: CharacterSet = {
    let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
    let subDelimitersToEncode = "!$&'()*+,;="

    var allowed: CharacterSet = .urlQueryAllowed
    allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
    return allowed
  }()
}

struct ResponseObject: Codable {

}
