//
//  SearchCoordinator.swift
//  MiniBootcamp
//
//  Created by Javier Cueto on 03/07/22.
//

import UIKit

final class SearchCoordinator: Coordinator {
    var rootViewController: UIViewController
    private var factory = SearchViewControllerFactory()
    
    init() {
        self.rootViewController = UINavigationController()
    }
    
    func start() {
        guard let rootViewController = rootViewController as? UINavigationController else { return }
        rootViewController.defaultConfig()
        rootViewController.pushViewController(factory.makeSearchController(), animated: false)
    }
    
    
}
