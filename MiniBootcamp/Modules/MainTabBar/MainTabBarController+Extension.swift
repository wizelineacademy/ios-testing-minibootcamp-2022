//
//  MainTabBarController+Extension.swift
//  MiniBootcamp
//
//  Created by Javier Cueto on 03/07/22.
//

import UIKit

extension MainTabBarController {
    
    enum TabBarItemConfig: Int {
        case home
        case search
        
        func title() -> String? {
            switch self {
            case .home:
                return MBConstants.appName
            case .search:
                return MBConstants.search
                
            }
        }
        
        func imageName() -> UIImage? {
            switch self {
            case .home:
                return  UIImage(systemName: "house")
                
            case .search:
                return UIImage(systemName: "magnifyingglass")
                
                
            }
        }
        
        func selectedImageName() -> UIImage? {
            switch self {
            case .home:
                return UIImage(systemName: "house.fill")
            case .search:
                return UIImage(systemName: "magnifyingglass")
            }
        }
    }
}
