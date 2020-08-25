//
//  AppCoordinator.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit

/// The App coordinator handles the UI from app start
/// The controllers are set to window's root
final class AppCoordinator: BaseCoordinator<UINavigationController> {
        
    // MARK: - Private properties
    private let window: UIWindow
        
    // MARK: - Lifecycle
    /// Initialize the app coordinator.
    /// - Parameter window: Primary window which the coordinator will work with
    init(window: UIWindow) {
        self.window = window
        super.init(rootViewController: UINavigationController())
    }
    
    // MARK: - Coordinator protocol methods
    /// The app starts with the login flow, so app coordinator start login flow on it's start
    override func startFlow() {
        startRestaurantListFlow()
        window.makeKeyAndVisible()
    }
    
    // MARK: - Private methods
    /// Start Restaurants list flow as the root of the application
    private func startRestaurantListFlow() {
        let restaurantsListCoordinator = RestaurantListCoordinator(rootViewController: rootViewController)
        childCoordinator = restaurantsListCoordinator
        restaurantsListCoordinator.startFlow()
        window.rootViewController = rootViewController
    }
}
