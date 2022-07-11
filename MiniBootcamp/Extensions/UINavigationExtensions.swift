////
////  UINavigationControllerExtensions.swift
////  MiniBootcamp
////
////  Created by Juan David Torres on 14/06/22.
////
//
//import Foundation
//import UIKit
//
//extension UINavigationController {
//
//    func setStatusBar(backgroundColor: UIColor) {
//        let statusBarFrame: CGRect
//        if #available(iOS 13.0, *) {
//            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
//        } else {
//            statusBarFrame = UIApplication.shared.statusBarFrame
//        }
//        let statusBarView = UIView(frame: statusBarFrame)
//        statusBarView.backgroundColor = backgroundColor
//        view.addSubview(statusBarView)
//    }
//
//}
