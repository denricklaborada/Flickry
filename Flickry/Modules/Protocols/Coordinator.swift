//
//  Coordinator.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import UIKit

// coordinator pattern
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
