//
//  RestaurantListCoordinator.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit

/// The restaurants list coordinator handles the presentation of Restaurants screen
final class RestaurantListCoordinator: BaseCoordinator<UINavigationController> {
    
    // MARK: - Coordinator protocol methods
    override func startFlow() {
        let controller = RestaurantListFactory().makeRestaurantListScreen()
        controller.navigationDelegate = self
        rootViewController.pushViewController(controller, animated: true)
    }
}

// MARK: - Restaurant list screen navigation protocol methods
extension RestaurantListCoordinator: RestaurantListViewControllerNavigationDelegate {
    func show(_ error: Error) {
        rootViewController.show(error)
    }
}
