//
//  SceneDelegate.swift
//  MiniBootcamp
//
//  Created by Abner Castro on 26/04/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator!


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let winScene = (scene as? UIWindowScene) else { return }
        //Create a window that is the same size as the screen
        window = UIWindow(windowScene: winScene)
        // Create a view controller
        let navigationController = UINavigationController()
        
        
        // Assign the view controller as `window`'s root view controller
        window?.rootViewController = navigationController
        
        let mainCoordinator = MainCoordinator(rootViewController: navigationController, viewControllerFactory: iOSViewControllerFactory())
        mainCoordinator.start()
        // Show the window
        window?.makeKeyAndVisible()
        
    }

}

