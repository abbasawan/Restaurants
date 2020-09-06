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
    private var delegate: RestaurantListViewModelDelegateMock!
    private var navigationDelegate: RestaurantListViewControllerNavigationDelegateMock!
    
    override func setUp() {
        super.setUp()
        
        apiProvider = RestaurantListApiProviderMock()
        sortingProvider = RestaurantSortingProviderMock()
        navigationDelegate = RestaurantListViewControllerNavigationDelegateMock()
        delegate = RestaurantListViewModelDelegateMock()
        viewModel = RestaurantListViewModel(apiProvider: apiProvider,
                                            sortingProvider: sortingProvider,
                                            defaultSortType: .bestMatch)
        viewModel.delegate = delegate
        viewModel.navigationDelegate = navigationDelegate
    }
    
    override func tearDown() {
        delegate = nil
        apiProvider = nil
        sortingProvider = nil
        viewModel.delegate = nil
        navigationDelegate = nil
        viewModel.navigationDelegate = nil
        viewModel = nil
        
        super.tearDown()
    }
    
    func testViewModel_whenInitialized_pickerViewModelShouldHaveCorrectNumberOfSortingOptions() {
        let allSortingOptions = RestaurantSortingType.allCases
        XCTAssertEqual(viewModel.sortingOptionsViewModel.pickerViewNumberOfRows(inComponent: 0),
                       allSortingOptions.count)
    }
    
    func testViewModel_whenViewDidLoadIsCalled_shouldLoadData() {
        viewModel.viewDidLoad()
        
        XCTAssertEqual(apiProvider.loadRestaurantListCallCount, 1)
    }
    
    func testViewModel_whenViewDidLoadIsCalledAndDataProviderReturnedError_shouldNotHaveDataAndCallErrorDelegate() {
        apiProvider.result = .failure(NetworkError.failedToLoad)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(viewModel.numberOfRows(in: 0), 0)
        XCTAssertEqual(delegate.reloadDataCallCount, 0)
        XCTAssertEqual(navigationDelegate.showErrorCallCount, 1)
    }
    
    func testViewModel_whenViewDidLoadIsCalledAndDataProviderIsSuccessful_shouldNotCallErrorAndshouldCallReloadDataDelegate() {
        apiProvider.result = .success([Restaurant.makeRestaurant()])
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(delegate.reloadDataCallCount, 1)
        XCTAssertEqual(navigationDelegate.showErrorCallCount, 0)
    }
    
    func testViewModel_whenDataIsSuccessfullyLoaded_shouldHaveCorrectNumberOfRows() {
        let restaurant1 = Restaurant.makeRestaurant()
        let restaurant2 = Restaurant.makeRestaurant()
        apiProvider.result = .success([restaurant1, restaurant2])
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(viewModel.numberOfRows(in: 0), 2)
        XCTAssertEqual(navigationDelegate.showErrorCallCount, 0)
    }
    
    func testViewModel_whenDataIsSuccessfullyLoadedAndRequestedCellViewModels_shouldReturnCorrectCellModels() {
        let sortingValues1 = Restaurant.SortingValues.makeSortingValues(bestMatch: 23.1)
        let restaurant1 = Restaurant.makeRestaurant(name: "1", sortingValues: sortingValues1)
        
        let sortingValues2 = Restaurant.SortingValues.makeSortingValues(bestMatch: 101.4)
        let restaurant2 = Restaurant.makeRestaurant(name: "2", sortingValues: sortingValues2)
        apiProvider.result = .success([restaurant1, restaurant2])
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(viewModel.numberOfRows(in: 0), 2)
        
        let cellViewModel1 = viewModel.cellViewModel(at: IndexPath(row: 0, section: 0))
        let cellViewModel2 = viewModel.cellViewModel(at: IndexPath(row: 1, section: 0))
        
        XCTAssertNotNil(cellViewModel1)
        XCTAssertNotNil(cellViewModel2)
        
        XCTAssertEqual(cellViewModel1?.title, restaurant1.name)
        XCTAssertEqual(cellViewModel2?.title, restaurant2.name)
    }
    
    func testViewModel_whenSortTypeIsChanged_shouldSortListAccordingly() {
        // Default sorting is set to .bestMatch in setup()
        let sortingValues1 = Restaurant.SortingValues.makeSortingValues(bestMatch: 23.1, popularity: 22)
        let restaurant1 = Restaurant.makeRestaurant(name: "1", sortingValues: sortingValues1)
        let sortingValues2 = Restaurant.SortingValues.makeSortingValues(bestMatch: 101.4, popularity: 12)
        let restaurant2 = Restaurant.makeRestaurant(name: "2", sortingValues: sortingValues2)
        let sortingValues3 = Restaurant.SortingValues.makeSortingValues(bestMatch: 75.0, popularity: 105)
        let restaurant3 = Restaurant.makeRestaurant(name: "3", sortingValues: sortingValues3)
        apiProvider.result = .success([restaurant1, restaurant2, restaurant3])
        
        viewModel.viewDidLoad()
        
        var cellViewModel1 = viewModel.cellViewModel(at: IndexPath(row: 0, section: 0))
        var cellViewModel2 = viewModel.cellViewModel(at: IndexPath(row: 1, section: 0))
        var cellViewModel3 = viewModel.cellViewModel(at: IndexPath(row: 2, section: 0))
        
        XCTAssertEqual(cellViewModel1?.title, restaurant1.name)
        XCTAssertEqual(cellViewModel2?.title, restaurant3.name)
        XCTAssertEqual(cellViewModel3?.title, restaurant2.name)
        
        sortingProvider.sortingMethod = {
            $0.sortingValues.popularity < $1.sortingValues.popularity
        }
        
        // Change the sort type
        viewModel.didSelectSortOption(.popularity)
        
        cellViewModel1 = viewModel.cellViewModel(at: IndexPath(row: 0, section: 0))
        cellViewModel2 = viewModel.cellViewModel(at: IndexPath(row: 1, section: 0))
        cellViewModel3 = viewModel.cellViewModel(at: IndexPath(row: 2, section: 0))
        
        XCTAssertEqual(cellViewModel1?.title, restaurant2.name)
        XCTAssertEqual(cellViewModel2?.title, restaurant1.name)
        XCTAssertEqual(cellViewModel3?.title, restaurant3.name)
    }
    
    func testViewModel_whenSearchTextIsChanged_shouldFilterListByNameAccordingly() {
        // Default sorting is set to .bestMatch in setup()
        let sortingValues1 = Restaurant.SortingValues.makeSortingValues(bestMatch: 23.1)
        let restaurant1 = Restaurant.makeRestaurant(name: "Pizza Heart", sortingValues: sortingValues1)
        let sortingValues2 = Restaurant.SortingValues.makeSortingValues(bestMatch: 101.4)
        let restaurant2 = Restaurant.makeRestaurant(name: "Sushi One", sortingValues: sortingValues2)
        let sortingValues3 = Restaurant.SortingValues.makeSortingValues(bestMatch: 75.0)
        let restaurant3 = Restaurant.makeRestaurant(name: "Tanoshii Sushi", sortingValues: sortingValues3)
        apiProvider.result = .success([restaurant1, restaurant2, restaurant3])
        
        viewModel.viewDidLoad()
        
        var cellViewModel1 = viewModel.cellViewModel(at: IndexPath(row: 0, section: 0))
        var cellViewModel2 = viewModel.cellViewModel(at: IndexPath(row: 1, section: 0))
        let cellViewModel3 = viewModel.cellViewModel(at: IndexPath(row: 2, section: 0))
        
        XCTAssertEqual(cellViewModel1?.title, restaurant1.name)
        XCTAssertEqual(cellViewModel2?.title, restaurant3.name)
        XCTAssertEqual(cellViewModel3?.title, restaurant2.name)
        
        // Filter by name
        viewModel.didChangeSearchBarText("sus")
        
        XCTAssertEqual(viewModel.numberOfRows(in: 0), 2)
        
        cellViewModel1 = viewModel.cellViewModel(at: IndexPath(row: 0, section: 0))
        cellViewModel2 = viewModel.cellViewModel(at: IndexPath(row: 1, section: 0))
        
        XCTAssertEqual(cellViewModel1?.title, restaurant3.name)
        XCTAssertEqual(cellViewModel2?.title, restaurant2.name)
    }
    
    func testViewModel_whenSearchTextIsEmptyAfterPreviousFiltering_shouldHaveFullRestaurantsList() {
        // Default sorting is set to .bestMatch in setup()
        let sortingValues1 = Restaurant.SortingValues.makeSortingValues(bestMatch: 23.1)
        let restaurant1 = Restaurant.makeRestaurant(name: "Pizza Heart", sortingValues: sortingValues1)
        let sortingValues2 = Restaurant.SortingValues.makeSortingValues(bestMatch: 101.4)
        let restaurant2 = Restaurant.makeRestaurant(name: "Sushi One", sortingValues: sortingValues2)
        let sortingValues3 = Restaurant.SortingValues.makeSortingValues(bestMatch: 75.0)
        let restaurant3 = Restaurant.makeRestaurant(name: "Tanoshii Sushi", sortingValues: sortingValues3)
        apiProvider.result = .success([restaurant1, restaurant2, restaurant3])
        
        viewModel.viewDidLoad()
        
        var cellViewModel1 = viewModel.cellViewModel(at: IndexPath(row: 0, section: 0))
        var cellViewModel2 = viewModel.cellViewModel(at: IndexPath(row: 1, section: 0))
        var cellViewModel3 = viewModel.cellViewModel(at: IndexPath(row: 2, section: 0))
        
        XCTAssertEqual(cellViewModel1?.title, restaurant1.name)
        XCTAssertEqual(cellViewModel2?.title, restaurant3.name)
        XCTAssertEqual(cellViewModel3?.title, restaurant2.name)
        
        // Filter by name
        viewModel.didChangeSearchBarText("p")
        
        // Should have only one restaurant
        XCTAssertEqual(viewModel.numberOfRows(in: 0), 1)
        
        cellViewModel1 = viewModel.cellViewModel(at: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(cellViewModel1?.title, restaurant1.name)
        
        // Remove the search term
        viewModel.didChangeSearchBarText("")
        
        XCTAssertEqual(viewModel.numberOfRows(in: 0), 3)
        
        cellViewModel1 = viewModel.cellViewModel(at: IndexPath(row: 0, section: 0))
        cellViewModel2 = viewModel.cellViewModel(at: IndexPath(row: 1, section: 0))
        cellViewModel3 = viewModel.cellViewModel(at: IndexPath(row: 2, section: 0))
        
        XCTAssertEqual(cellViewModel1?.title, restaurant1.name)
        XCTAssertEqual(cellViewModel2?.title, restaurant3.name)
        XCTAssertEqual(cellViewModel3?.title, restaurant2.name)
    }
}
