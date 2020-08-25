//
//  AppCoordinatorTests.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 25.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import XCTest
@testable import Restaurants

final class AppCoordinatorTests: XCTestCase {
    private var appCoordinator: AppCoordinator!
    private var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow(frame: .zero)
        appCoordinator = AppCoordinator(window: window)
    }
    
    override func tearDown() {
        window = nil
        appCoordinator = nil
        
        super.tearDown()
    }
    
    func testAppCoordinator_whenInitialized_shouldNotHaveParentOrChildCoordinator() {
        let appCoordinator = AppCoordinator(window: UIWindow(frame: .zero))
        
        XCTAssertNil(appCoordinator.parentCoordinator)
        XCTAssertNil(appCoordinator.childCoordinator)
    }
    
    func testAppCoordinator_whenFlowStarted_shouldHaveRestaurantListViewControllerAsRoot() {
        appCoordinator.startFlow()
        
        XCTAssertTrue(window.rootViewController is UINavigationController)
        let rootController = window.rootViewController as? UINavigationController
        XCTAssertTrue(rootController?.viewControllers.first is RestaurantListViewController)
    }
}
