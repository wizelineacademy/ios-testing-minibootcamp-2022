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
    case statusUpdate(String)
}

extension Endpoint {
    var string: String {
        switch self {
        case .timeline:
            return "/api/statuses/user_timeline"
        case .statusUpdate(_):
            return "/api/statuses/update"
        }
    }
    
    var request: URLRequest {
        switch self {
        case .timeline:
            let url = URL(string: Endpoint.baseURL + string)!
            return URLRequest(url: url)
        case .statusUpdate(let content):
            let url = URL(string: Endpoint.baseURL + string)!
            var req = URLRequest(url: url)
            req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            req.httpBody = "content=\(content)".data(using: .utf8)
            return req
        }
    }
}
