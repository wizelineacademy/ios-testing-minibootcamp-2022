//
//  TweetTimelineAPI.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 22/04/22.
//

import Foundation

enum TweetAPIError: Error {
    case noData
    case response
    case parsingData
}

struct TweetTimelineAPI {
    
    let session: URLSession
    
    func load(_ endpoint: Endpoint, completion: @escaping (Result<[Tweet], Error>) -> ()) {
        
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
                let timeline = try JSONDecoder().decode([Tweet].self, from: data)
                completion(.success(timeline))
                
            } catch {
                completion(.failure(TweetAPIError.parsingData))
            }
            
        }.resume()
    }
    
}
