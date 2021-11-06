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
        
    }
    
    func showSearchResults() {
        
    }
}
