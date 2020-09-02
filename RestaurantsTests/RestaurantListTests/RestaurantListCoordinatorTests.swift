//
//  RestaurantListCoordinatorTests.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 03.09.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import XCTest
@testable import Restaurants

final class RestaurantListCoordinatorTests: XCTestCase {
    private var restaurantListCoordinator: RestaurantListCoordinator!
    private var rootViewController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        
        rootViewController = UINavigationController()
        restaurantListCoordinator = RestaurantListCoordinator(rootViewController: rootViewController)
    }
    
    override func tearDown() {
        rootViewController = nil
        restaurantListCoordinator = nil
        
        super.tearDown()
    }
    
    func testRestaurantListCoordinator_whenFlowStarted_shouldHaveRestaurantListViewControllerAsRoot() {
        restaurantListCoordinator.startFlow()
        
        XCTAssertNil(restaurantListCoordinator.parentCoordinator)
        XCTAssertNil(restaurantListCoordinator.childCoordinator)
        XCTAssertTrue(rootViewController.viewControllers.first is RestaurantListViewController)
    }
}

