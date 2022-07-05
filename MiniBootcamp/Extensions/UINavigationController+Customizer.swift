//
//  UIViewController.swift
//  MiniBootcamp
//
//  Created by Javier Cueto on 03/07/22.
//

import UIKit

extension UINavigationController {
    
    func defaultConfig() {
        navigationBar.prefersLargeTitles = false
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .redMain
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.overrideUserInterfaceStyle = .dark
        navigationBar.tintColor = .white
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
