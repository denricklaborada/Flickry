//
//  MainCoordinator.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = MainViewController.generateFromStoryboard()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: false)
    }
    
    func showSearchResults(searchString: String) {
        let controller = ResultsViewController.generateFromStoryboard(input: .init(searchString: searchString))
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
}
