//
//  SceneDelegate.swift
//  MiniBootcamp
//
//  Created by Abner Castro on 26/04/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    let navigationController = UINavigationController()
    let viewControllerFactory = iOSViewControllerFactory()
    let coordinator = MainCoordinator(rootViewController: navigationController, viewControllerFactory: viewControllerFactory)
    window.rootViewController =  navigationController
    self.window = window
    coordinator.start()
    window.makeKeyAndVisible()
  }

}

