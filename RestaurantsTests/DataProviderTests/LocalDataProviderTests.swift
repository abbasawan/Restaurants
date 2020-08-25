//
//  LocalDataProviderTests.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 25.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import XCTest
@testable import Restaurants

final class LocalDataProviderTests: XCTestCase {
    private var dataProvider: LocalDataProvider!
    
    override func setUp() {
        super.setUp()
        
        dataProvider = LocalDataProvider()
    }

    override func tearDown() {
        dataProvider = nil
        
        super.tearDown()
    }

    func testLocalDataProvider_whenInitialized_shouldNotBeNil() {
        let provider = LocalDataProvider()
        
        XCTAssertNotNil(provider)
    }
    
    func testLocalDataProvider_withInvalidRequestPath_shouldReturnError() {
        let expectation = self.expectation(description: #function)
        let request = RestaurantListApiRequestMock(path: "InvalidFilePath")
        
        dataProvider.execute(request: request) { (result) in
            switch result {
            case .success(_):
                XCTFail("Should return error")
            case .failure(let error):
                XCTAssertTrue(error is NetworkError)
                XCTAssertEqual(error.localizedDescription, NetworkError.invalidPath.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testLocalDataProvider_withEmptyFile_shouldReturnError() {
        let expectation = self.expectation(description: #function)
        let request = RestaurantListApiRequestMock(path: "RestaurantsEmptyData")
        
        dataProvider.execute(request: request) { (result) in
            switch result {
            case .success(_):
                XCTFail("Should return error")
            case .failure(let error):
                let nsError = error as NSError
                XCTAssertEqual(nsError.code, NSCoderValueNotFoundError) // Data requested was not found
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testLocalDataProvider_withMismatchedData_shouldReturnParsingError() {
        let expectation = self.expectation(description: #function)
        let request = RestaurantListApiRequestMock(path: "Starship")
        
        dataProvider.execute(request: request) { (result) in
            switch result {
            case .success(_):
                XCTFail("Should return error")
            case .failure(let error):
                let nsError = error as NSError
                XCTAssertEqual(nsError.code, NSCoderReadCorruptError) // Error parsing data during decode
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testLocalDataProvider_withEmptyRestaurants_shouldSucceedAndReturnEmptyData() {
        let expectation = self.expectation(description: #function)
        let request = RestaurantListApiRequestMock(path: "RestaurantsEmptyList")
        
        dataProvider.execute(request: request) { (result) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.restaurants.count, 0)
            case .failure(_):
                XCTFail("Should not return error")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testLocalDataProvider_withValidDataFile_shouldReturnValidData() {
        let expectation = self.expectation(description: #function)
        let request = RestaurantListApiRequestMock(path: "Restaurants")
        
        dataProvider.execute(request: request) { (result) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.restaurants.count, 19)
            case .failure(_):
                XCTFail("Should not return error")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
}
