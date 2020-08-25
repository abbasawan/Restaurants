//
//  AppDelegate.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit

@UIApplicationMain

final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Public properties
    var window: UIWindow?
    
    // MARK: Private properties
    private lazy var coordinator: AppCoordinator = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        return AppCoordinator(window: window)
    }()

    // MARK: UIApplication delegate methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        coordinator.startFlow()

        return true
    }
}

