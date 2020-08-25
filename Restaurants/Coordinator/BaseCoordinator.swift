//
//  BaseCoordinator.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit

/// The base coordinator helps to handle boiler plate code and helps avoid code reusability
class BaseCoordinator<T: UIViewController>: Coordinator {
    let rootViewController: T
    
    // MARK: - Protocol properties
    /// The parent flow coordinator that started this flow
    weak var parentCoordinator: Coordinator?
    
    /// A child flow coordinator started from this flow
    var childCoordinator: Coordinator? {
        didSet {
            childCoordinator?.parentCoordinator = self
        }
    }
    
    // MARK: - Lifecycle
    init(rootViewController: T) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - Coordinator protocol methods
    func startFlow() {
        // Child coordinators will provide implementation
        assertionFailure("Child class must override this method")
    }
    
    /// Method that is called by child coordinator informing the end of their flow
    func didFinishChildFlow() {
        childCoordinator = nil
    }
}
