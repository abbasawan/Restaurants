//
//  RestaurantListViewModelDelegateMock.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 04.09.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation
@testable import Restaurants

final class RestaurantListViewModelDelegateMock: RestaurantListViewModelDelegate {
    private(set) var reloadDataCallCount = 0
    
    func shouldReloadData() {
        reloadDataCallCount += 1
    }
}
