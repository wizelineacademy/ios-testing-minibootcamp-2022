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
    case search(String)
}

extension Endpoint {
    var string: String {
        switch self {
        case .timeline:
            return "/api/statuses/user_timeline"
        case .search(let text):
            return "/api/search/\(text)"
        }
    }
    
    var request: URLRequest {
        switch self {
        case .timeline:
            let url = URL(string: Endpoint.baseURL + string)!
            return URLRequest(url: url)
        case .search:
            let url = URL(string: Endpoint.baseURL + string)!
            print(url.absoluteString)
            return URLRequest(url: url)
        }
    }
}
