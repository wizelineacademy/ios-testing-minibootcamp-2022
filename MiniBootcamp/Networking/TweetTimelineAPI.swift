//
//  TweetTimelineAPI.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 22/04/22.
//

import Foundation
import UIKit

enum TweetAPIError: Error {
    case noData
    case response
    case parsingData
}

struct TweetTimelineAPI {
    
    func load(_ endpoint: Endpoint, completion: @escaping (Result<[Tweet], Error>) -> ()) {
        
        let request = endpoint.request
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion(.failure(TweetAPIError.noData))
                return
            }
            
            if let error = error {
                completion(.failure(error))
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
    
    
    func fethImage(url:URL, completion: @escaping(UIImage?)->Void) {
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            
            if error != nil && data == nil {
                print(error as Any)
                return
            }
            
            let image = UIImage(data: (data as Data?)!)
            
            DispatchQueue.main.async {
                completion(image)
            }
            
            
        }.resume()
    }
    
}

