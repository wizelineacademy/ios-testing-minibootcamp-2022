//
//  Coordinator.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 25/04/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var rootViewController: UIViewController { get set }
    func start()
}
