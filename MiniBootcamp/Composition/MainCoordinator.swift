//
//  MainCoordinator.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 07/04/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    var viewControllerFactory: ViewControllerFactory
    
    init(rootViewController: UINavigationController, viewControllerFactory: ViewControllerFactory) {
        self.rootViewController = rootViewController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let feedVC = viewControllerFactory.feedViewController() as! FeedViewController
        feedVC.coordinator = self
        rootViewController.pushViewController(feedVC, animated: false)
    }
    
    func showDetail(tweetViewModel: TweetViewModel, userViewModel:UserViewModel, userImage: UIImage) {
        rootViewController.pushViewController(viewControllerFactory.detailViewController(tweetViewModel: tweetViewModel, userViewModel: userViewModel, userImage: userImage), animated: true)
        
    }
}
