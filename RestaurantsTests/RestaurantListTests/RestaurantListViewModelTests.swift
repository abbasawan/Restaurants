//
//  RestaurantListViewModelTests.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 25.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import XCTest
@testable import Restaurants

final class RestaurantListViewModelTests: XCTestCase {
    private var viewModel: RestaurantListViewModel!
    private var apiProvider: RestaurantListApiProviderMock!
    
    override func setUp() {
        super.setUp()
        
        apiProvider = RestaurantListApiProviderMock()
        viewModel = RestaurantListViewModel(apiProvider: apiProvider)
    }

    override func tearDown() {
        apiProvider = nil
        viewModel.delegate = nil
        viewModel.navigationDelegate = nil
        viewModel = nil

        super.tearDown()
    }
}
