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
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        navigationBar.tintColor = .systemBackground
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
