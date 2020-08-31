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
    private var sortingProvider: RestaurantSortingProviderMock!
    
    override func setUp() {
        super.setUp()
        
        apiProvider = RestaurantListApiProviderMock()
        viewModel = RestaurantListViewModel(apiProvider: apiProvider, sortingProvider: sortingProvider)
    }

    override func tearDown() {
        apiProvider = nil
        sortingProvider = nil
        viewModel.delegate = nil
        viewModel.navigationDelegate = nil
        viewModel = nil

        super.tearDown()
    }
}
