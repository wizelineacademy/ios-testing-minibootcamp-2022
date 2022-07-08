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
  case userProfile
}

extension Endpoint {
    var string: String {
        switch self {
        case .timeline:
            return "/api/statuses/user_timeline"
        case .postTweet:
          return "/api/statuses/update"
        case .userProfile:
          return "/api/user"
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
    case .userProfile:
      let url = URL(string: Endpoint.baseURL + string)!
      return URLRequest(url: url)
    }
  }
}

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
