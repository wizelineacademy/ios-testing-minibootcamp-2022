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
       
        return FeedViewController()
    
    }
    
    func detailViewController( tweetViewModel: TweetViewModel, userViewModel: UserViewModel, userImage: UIImage) -> UIViewController{
        DetailViewController(tweetViewModel, userViewModel, userImage)
    }
//
//    func composeViewController(_ coordinator: MainCoordinator) -> UIViewController {
//        ComposeViewController(coordinator)
//    }
}
