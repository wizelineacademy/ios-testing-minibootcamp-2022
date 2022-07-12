//
//  iOSViewControllerFactory.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 07/04/22.
//

import Foundation
import UIKit

class iOSViewControllerFactory: ViewControllerFactory {
    
    func feedViewController() -> UIViewController {
        FeedViewController()
    }
    
    func detailViewController(tweetViewModel: TweetViewModel, userViewModel:UserViewModel, userImage: UIImage) -> UIViewController {
        return DetailViewController(tweetViewModel, userViewModel, userImage)
    }
    
}
