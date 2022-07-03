//
//  MainCoordinator.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 07/04/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var rootViewController: UIViewController
    var viewControllerFactory: ViewControllerFactory
    
    init(rootViewController: UINavigationController, viewControllerFactory: ViewControllerFactory) {
        self.rootViewController = rootViewController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        //rootViewController.defaultConfig()
        rootViewController = viewControllerFactory.mainViewController()// , animated: false)
    }
    
}
