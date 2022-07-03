//
//  MainTabBarController.swift
//  MiniBootcamp
//
//  Created by Javier Cueto on 03/07/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBar()
        
    }
    
    private func configTabBar() {
        view.tintColor = .redMain
        let coordinator = FeedCoordinator()
        coordinator.start()
        let feedController = coordinator.rootViewController
        feedController.tabBarItem = UITabBarItem(title: TabBarItemConfig.home.title(), image: TabBarItemConfig.home.imageName(), selectedImage: TabBarItemConfig.home.selectedImageName())
        
        let searchCoordinator = SearchCoordinator()
        searchCoordinator.start()
        let searchController = searchCoordinator.rootViewController
        searchController.tabBarItem = UITabBarItem(title: TabBarItemConfig.search.title(), image: TabBarItemConfig.search.imageName(), selectedImage: TabBarItemConfig.search.selectedImageName())
        
        viewControllers = [feedController,searchController]
    }
    
}
