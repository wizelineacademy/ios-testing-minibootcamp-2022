//
//  ViewControllerFactory.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 25/04/22.
//

import Foundation
import UIKit

protocol ViewControllerFactory {
    func feedViewController() -> UIViewController
    func detailViewController( tweetViewModel: TweetViewModel, userViewModel: UserViewModel, userImage: UIImage) -> UIViewController
//    func composeViewController(_ coordinator: MainCoordinator) -> UIViewController
}
