//
//  RestaurantSortingProviderTests.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 31.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import XCTest
@testable import Restaurants

final class RestaurantSortingProviderTests: XCTestCase {
    private var sortingProvider: RestaurantSortingProvider!
    private var restaurants: [Restaurant]!
    
    override func setUp() {
        super.setUp()
        
        restaurants = makeRestaurants()
        sortingProvider = RestaurantSortingProvider()
    }
    
    override func tearDown() {
        restaurants = nil
        sortingProvider = nil
        
        super.tearDown()
    }
    
    func testSortingProvider_whenSortedByBestMatch_shouldBeSortedByBestMatchInDescendingOrder() {
        let expected = ["1","2","4","3","6","5"]
        
        restaurants.sort(by: sortingProvider.sorter(for: .bestMatch))
        
        // assert the order of restaurants by their ids
        assertEqual(expected, restaurants, for: \.id)
        
        // .open restaurants are at top
        assertDescending(a: restaurants[0], b: restaurants[1], path: \.bestMatch)
        
        // .orderAhead restaurants are in the middle
        assertDescending(a: restaurants[2], b: restaurants[3], path: \.bestMatch)
        
        // .closed restaurants are at the end
        assertDescending(a: restaurants[4], b: restaurants[5], path: \.bestMatch)
    }
    
    func testSortingProvider_whenSortedByNewest_shouldBeSortedByNewestInDescendingOrder() {
        let expected = ["2","1","3","4","5","6"]
        
        restaurants.sort(by: sortingProvider.sorter(for: .newest))
        
        // assert the order of restaurants by their ids
        assertEqual(expected, restaurants, for: \.id)
        
        // .open restaurants are at top
        assertDescending(a: restaurants[0], b: restaurants[1], path: \.newest)
        
        // .orderAhead restaurants are in the middle
        assertDescending(a: restaurants[2], b: restaurants[3], path: \.newest)
        
        // .closed restaurants are at the end
        assertDescending(a: restaurants[4], b: restaurants[5], path: \.newest)
    }
    
    func testSortingProvider_whenSortedByAverageRating_shouldBeSortedByAverageRatingInDescendingOrder() {
        let expected = ["1","2","4","3","6","5"]
        
        restaurants.sort(by: sortingProvider.sorter(for: .ratingAverage))
        
        // assert the order of restaurants by their ids
        assertEqual(expected, restaurants, for: \.id)
        
        // .open restaurants are at top
        assertDescending(a: restaurants[0], b: restaurants[1], path: \.ratingAverage)
        
        // .orderAhead restaurants are in the middle
        assertDescending(a: restaurants[2], b: restaurants[3], path: \.ratingAverage)
        
        // .closed restaurants are at the end
        assertDescending(a: restaurants[4], b: restaurants[5], path: \.ratingAverage)
    }
    
    func testSortingProvider_whenSortedByDistance_shouldBeSortedByDistanceInAscendingOrder() {
        let expected = ["1","2","4","3","5","6"]
        
        restaurants.sort(by: sortingProvider.sorter(for: .distance))
        
        // assert the order of restaurants by their ids
        assertEqual(expected, restaurants, for: \.id)
        
        // .open restaurants are at top
        assertAscending(a: restaurants[0], b: restaurants[1], path: \.distance)
        
        // .orderAhead restaurants are in the middle
        assertAscending(a: restaurants[2], b: restaurants[3], path: \.distance)
        
        // .closed restaurants are at the end
        assertAscending(a: restaurants[4], b: restaurants[5], path: \.distance)
    }
    
    func testSortingProvider_whenSortedByPopularity_shouldBeSortedByPopularityInDescendingOrder() {
        let expected = ["2","1","3","4","6","5"]
        
        restaurants.sort(by: sortingProvider.sorter(for: .popularity))
        
        // assert the order of restaurants by their ids
        assertEqual(expected, restaurants, for: \.id)
        
        // .open restaurants are at top
        assertDescending(a: restaurants[0], b: restaurants[1], path: \.popularity)
        
        // .orderAhead restaurants are in the middle
        assertDescending(a: restaurants[2], b: restaurants[3], path: \.popularity)
        
        // .closed restaurants are at the end
        assertDescending(a: restaurants[4], b: restaurants[5], path: \.popularity)
    }
    
    func testSortingProvider_whenSortedByAveragePrice_shouldBeSortedByAveragePriceInAscendingOrder() {
        let expected = ["2","1","3","4","6","5"]
        
        restaurants.sort(by: sortingProvider.sorter(for: .averageProductPrice))
        
        // assert the order of restaurants by their ids
        assertEqual(expected, restaurants, for: \.id)
        
        // .open restaurants are at top
        assertAscending(a: restaurants[0], b: restaurants[1], path: \.averageProductPrice)
        
        // .orderAhead restaurants are in the middle
        assertAscending(a: restaurants[2], b: restaurants[3], path: \.averageProductPrice)
        
        // .closed restaurants are at the end
        assertAscending(a: restaurants[4], b: restaurants[5], path: \.averageProductPrice)
    }
    
    func testSortingProvider_whenSortedByDeliveryCost_shouldBeSortedByDeliveryCostInAscendingOrder() {
        let expected = ["1","2","3","4","6","5"]
        
        restaurants.sort(by: sortingProvider.sorter(for: .deliveryCosts))
        
        // assert the order of restaurants by their ids
        assertEqual(expected, restaurants, for: \.id)
        
        // .open restaurants are at top
        assertAscending(a: restaurants[0], b: restaurants[1], path: \.deliveryCosts)
        
        // .orderAhead restaurants are in the middle
        assertAscending(a: restaurants[2], b: restaurants[3], path: \.deliveryCosts)
        
        // .closed restaurants are at the end
        assertAscending(a: restaurants[4], b: restaurants[5], path: \.deliveryCosts)
    }
    
    func testSortingProvider_whenSortedByMinimumCost_shouldBeSortedByMinimumCostInAscendingOrder() {
        let expected = ["1","2","4","3","6","5"]
        
        restaurants.sort(by: sortingProvider.sorter(for: .minCost))
        
        // assert the order of restaurants by their ids
        assertEqual(expected, restaurants, for: \.id)
        
        // .open restaurants are at top
        assertAscending(a: restaurants[0], b: restaurants[1], path: \.minCost)
        
        // .orderAhead restaurants are in the middle
        assertAscending(a: restaurants[2], b: restaurants[3], path: \.minCost)
        
        // .closed restaurants are at the end
        assertAscending(a: restaurants[4], b: restaurants[5], path: \.minCost)
    }
    
    /// Assert if the parameter a is less than or equal to parameter b for certain property
    /// - Parameters:
    ///   - a: Restaurant that is expected to have be lower in the order
    ///   - b: Restaurant that is expected to have be higher in the order
    ///   - path: KeyPath for which the restaurant objects will be asserted
    private func assertAscending<T: Comparable>(a: Restaurant, b: Restaurant, path: KeyPath<Restaurant, T>) {
        XCTAssertLessThanOrEqual(a[keyPath: path], b[keyPath: path])
    }
    
    /// Assert if the parameter a is greater than or equal to parameter b for certain property
    /// - Parameters:
    ///   - a: Restaurant that is expected to have be higher in the order
    ///   - b: Restaurant that is expected to have be lower in the order
    ///   - path: KeyPath for which the restaurant objects will be asserted
    private func assertDescending<T: Comparable>(a: Restaurant, b: Restaurant, path: KeyPath<Restaurant, T>) {
        XCTAssertGreaterThanOrEqual(a[keyPath: path], b[keyPath: path])
    }
    
    /// Assert if expected result is equal to certain keypath for the list of restaurants
    /// - Parameters:
    ///   - expected: An array of expect values
    ///   - restaurants: List of restaurants which will be asserted
    ///   - keyPath: KeyPath for which the restaurant objects will be asserted
    private func assertEqual<T: Comparable>(_ expected: [T],
                                            _ restaurants: [Restaurant],
                                            for keyPath: KeyPath<Restaurant, T>) {
        let result = restaurants.map({ $0[keyPath: keyPath] })
        
        XCTAssertEqual(result, expected)
    }
    
    /// Make and return a list of restaurants with different id, status and sorting values
    /// - Returns: List of restaurant
    private func makeRestaurants() -> [Restaurant] {
        let sortingValues1 = Restaurant.SortingValues.makeSortingValues(bestMatch: 23.1,
                                                                        newest: 1.2,
                                                                        ratingAverage: 3.5,
                                                                        distance: 445,
                                                                        popularity: 22.2,
                                                                        averageProductPrice: 434,
                                                                        deliveryCosts: 325,
                                                                        minCost: 440)
        let restaurant1 = Restaurant.makeRestaurant(id: "1", status: .open, sortingValues: sortingValues1)
        
        let sortingValues2 = Restaurant.SortingValues.makeSortingValues(bestMatch: 11.4,
                                                                        newest: 55,
                                                                        ratingAverage: 2.6,
                                                                        distance: 5435,
                                                                        popularity: 88.2,
                                                                        averageProductPrice: 230,
                                                                        deliveryCosts: 400,
                                                                        minCost: 840)
        let restaurant2 = Restaurant.makeRestaurant(id: "2", status: .open, sortingValues: sortingValues2)
        
        let sortingValues3 = Restaurant.SortingValues.makeSortingValues(bestMatch: 1000,
                                                                        newest: 44,
                                                                        ratingAverage: 4.9,
                                                                        distance: 333,
                                                                        popularity: 12.1,
                                                                        averageProductPrice: 4000,
                                                                        deliveryCosts: 0,
                                                                        minCost: 899)
        let restaurant3 = Restaurant.makeRestaurant(id: "3", status: .orderAhead, sortingValues: sortingValues3)
        
        let sortingValues4 = Restaurant.SortingValues.makeSortingValues(bestMatch: 5000,
                                                                        newest: 2.2,
                                                                        ratingAverage: 4.9,
                                                                        distance: 102,
                                                                        popularity: 11.9,
                                                                        averageProductPrice: 5500,
                                                                        deliveryCosts: 350,
                                                                        minCost: 800)
        let restaurant4 = Restaurant.makeRestaurant(id: "4", status: .orderAhead, sortingValues: sortingValues4)
        
        let sortingValues5 = Restaurant.SortingValues.makeSortingValues(bestMatch: 11,
                                                                        newest: 1200,
                                                                        ratingAverage: 2.8,
                                                                        distance: 12,
                                                                        popularity: 55,
                                                                        averageProductPrice: 434,
                                                                        deliveryCosts: 6000,
                                                                        minCost: 1244)
        let restaurant5 = Restaurant.makeRestaurant(id: "5", status: .closed, sortingValues: sortingValues5)
        
        let sortingValues6 = Restaurant.SortingValues.makeSortingValues(bestMatch: 200,
                                                                        newest: 2.2,
                                                                        ratingAverage: 4.9,
                                                                        distance: 102,
                                                                        popularity: 250,
                                                                        averageProductPrice: 299,
                                                                        deliveryCosts: 100,
                                                                        minCost: 899)
        let restaurant6 = Restaurant.makeRestaurant(id: "6", status: .closed, sortingValues: sortingValues6)
        
        return [restaurant1, restaurant4, restaurant2, restaurant6, restaurant5, restaurant3]
    }
}
