//
//  StatusSortingTests.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 29.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import XCTest
@testable import Restaurants

final class StatusSortingTests: XCTestCase {
    private typealias Status = Restaurant.Status
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRestaurantSorting_openShouldBeGreaterThanOrderAhead() {
        let open = Status.open
        let orderAhead = Status.orderAhead
        
        XCTAssertGreaterThan(open, orderAhead)
    }
    
    func testRestaurantSorting_openShouldBeGreaterThanClosed() {
        let open = Status.open
        let closed = Status.closed
        
        XCTAssertGreaterThan(open, closed)
    }
    
    func testRestaurantSorting_orderAheadShouldBeLessThanOpen() {
        let open = Status.open
        let orderAhead = Status.orderAhead

        XCTAssertLessThan(orderAhead, open)
    }
    
    func testRestaurantSorting_orderAheadShouldBeGreaterThanClosed() {
        let orderAhead = Status.orderAhead
        let closed = Status.closed
        
        XCTAssertGreaterThan(orderAhead, closed)
    }
    
    func testRestaurantSorting_closedShouldBeLessThanOpen() {
        let open = Status.open
        let closed = Status.closed

        XCTAssertLessThan(closed, open)
    }
    
    func testRestaurantSorting_closedShouldBeLessThanOrderAhead() {
        let orderAhead = Status.orderAhead
        let closed = Status.closed

        XCTAssertLessThan(closed, orderAhead)
    }
}
