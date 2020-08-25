//
//  RestaurantListApiProviderTests.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 25.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import XCTest
@testable import Restaurants

final class RestaurantListApiProviderTests: XCTestCase {
    private var dataProvider: DataProviderMock<RestaurantsResponse>!
    private var apiProvider: RestaurantListApiProvider!
    
    override func setUp() {
        super.setUp()
        
        dataProvider = DataProviderMock()
        apiProvider = RestaurantListApiProvider(dataProvider: dataProvider)
    }
    
    override func tearDown() {
        dataProvider = nil
        apiProvider = nil
        
        super.tearDown()
    }
    
    func testApiProvider_whenDataServiceHasError_shouldReturnError() {
        let expectation = self.expectation(description: #function)
        dataProvider.result = .failure(NetworkError.failedToLoad)
        
        apiProvider.loadRestaurantList { (result) in
            switch result {
            case .success(_):
                XCTFail("Should not succeed")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testApiProvider_whenDataServiceHasValidData_shouldReturnRestaurants() {
        let expectation = self.expectation(description: #function)
        dataProvider.result = .success(RestaurantsResponse.makeRestaurantsResponse())
        
        apiProvider.loadRestaurantList { (result) in
            switch result {
            case .success(let restaurants):
                XCTAssertNotNil(restaurants)
                XCTAssertEqual(restaurants.count, 1)
            case .failure(let error):
                XCTFail(error.localizedDescription)
                XCTFail("Should not fail")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testApiProvider_whenDataServiceHasEmptyData_shouldSucceedAndReturnNoRestaurants() {
        let expectation = self.expectation(description: #function)
        dataProvider.result = .success(RestaurantsResponse.makeRestaurantsResponse(restaurants: []))
        
        apiProvider.loadRestaurantList { (result) in
            switch result {
            case .success(let restaurants):
                XCTAssertNotNil(restaurants)
                XCTAssertEqual(restaurants.count, 0)
            case .failure(let error):
                XCTFail(error.localizedDescription)
                XCTFail("Should not fail")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testApiProvider_whenDataServiceHasInvalidData_shouldReturnError() {
        let expectation = self.expectation(description: #function)
        let dataProvider = DataProviderMock<[String]>()
        dataProvider.result = .success(["Invalid Type 1", "Invalid Type 2"])
        let apiProvider = RestaurantListApiProvider(dataProvider: dataProvider)
        
        apiProvider.loadRestaurantList { (result) in
            switch result {
            case .success(_):
                XCTFail("Should not succeed")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
}
