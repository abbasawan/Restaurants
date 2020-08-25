//
//  Coordinator.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

/// Coordinator Protocol that dictates the flow of the application/screens
protocol Coordinator: class {
    /// Method to show relevant screen
    func startFlow()
    
    /// Method to inform parent that child coordinator has finished flow
    func didFinishChildFlow()
    
    /// Reference to parent coordinator
    var parentCoordinator: Coordinator? { get set }
    
    /// A child flow coordinator started from this flow
    var childCoordinator: Coordinator? { get }
}
