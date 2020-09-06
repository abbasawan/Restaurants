//
//  RestaurantListViewControllerNavigationDelegateMock.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 04.09.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation
@testable import Restaurants

final class RestaurantListViewControllerNavigationDelegateMock: RestaurantListViewControllerNavigationDelegate {
    private(set) var showErrorCallCount = 0
    
    func show(_ error: Error) {
        showErrorCallCount += 1
    }
}
