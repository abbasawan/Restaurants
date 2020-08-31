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
        restaurants.sort(by: sortingProvider.sorter(for: .bestMatch))
        
        XCTAssertEqual(restaurants[0].id, "2")
        XCTAssertEqual(restaurants[1].id, "1")
        XCTAssertEqual(restaurants[2].id, "3")
        assertDescending(a: restaurants[0].sortingValues.bestMatch,
                         b: restaurants[1].sortingValues.bestMatch,
                         c: restaurants[2].sortingValues.bestMatch)
    }
    
    func testSortingProvider_whenSortedByNewest_shouldBeSortedByNewestInDescendingOrder() {
        restaurants.sort(by: sortingProvider.sorter(for: .newest))
        
        XCTAssertEqual(restaurants[0].id, "3")
        XCTAssertEqual(restaurants[1].id, "2")
        XCTAssertEqual(restaurants[2].id, "1")
        assertDescending(a: restaurants[0].sortingValues.newest,
                         b: restaurants[1].sortingValues.newest,
                         c: restaurants[2].sortingValues.newest)
    }
    
    func testSortingProvider_whenSortedByAverageRating_shouldBeSortedByAverageRatingInDescendingOrder() {
        restaurants.sort(by: sortingProvider.sorter(for: .ratingAverage))
        
        XCTAssertEqual(restaurants[0].id, "2")
        XCTAssertEqual(restaurants[1].id, "1")
        XCTAssertEqual(restaurants[2].id, "3")
        assertDescending(a: restaurants[0].sortingValues.ratingAverage,
                         b: restaurants[1].sortingValues.ratingAverage,
                         c: restaurants[2].sortingValues.ratingAverage)
    }
    
    func testSortingProvider_whenSortedByDistance_shouldBeSortedByDistanceInAscendingOrder() {
        restaurants.sort(by: sortingProvider.sorter(for: .distance))
        
        XCTAssertEqual(restaurants[0].id, "3")
        XCTAssertEqual(restaurants[1].id, "2")
        XCTAssertEqual(restaurants[2].id, "1")
        assertAscending(a: restaurants[0].sortingValues.distance,
                        b: restaurants[1].sortingValues.distance,
                        c: restaurants[2].sortingValues.distance)
    }
    
    func testSortingProvider_whenSortedByPopularity_shouldBeSortedByPopularityInDescendingOrder() {
        restaurants.sort(by: sortingProvider.sorter(for: .popularity))
        
        XCTAssertEqual(restaurants[0].id, "3")
        XCTAssertEqual(restaurants[1].id, "1")
        XCTAssertEqual(restaurants[2].id, "2")
        assertDescending(a: restaurants[0].sortingValues.popularity,
                         b: restaurants[1].sortingValues.popularity,
                         c: restaurants[2].sortingValues.popularity)
    }
    
    func testSortingProvider_whenSortedByAveragePrice_shouldBeSortedByAveragePriceInAscendingOrder() {
        restaurants.sort(by: sortingProvider.sorter(for: .averageProductPrice))
        
        XCTAssertEqual(restaurants[0].id, "1")
        XCTAssertEqual(restaurants[1].id, "3")
        XCTAssertEqual(restaurants[2].id, "2")
        assertAscending(a: restaurants[0].sortingValues.averageProductPrice,
                        b: restaurants[1].sortingValues.averageProductPrice,
                        c: restaurants[2].sortingValues.averageProductPrice)
    }
    
    func testSortingProvider_whenSortedByDeliveryCost_shouldBeSortedByDeliveryCostInAscendingOrder() {
        restaurants.sort(by: sortingProvider.sorter(for: .deliveryCosts))
        
        XCTAssertEqual(restaurants[0].id, "2")
        XCTAssertEqual(restaurants[1].id, "1")
        XCTAssertEqual(restaurants[2].id, "3")
        assertAscending(a: restaurants[0].sortingValues.deliveryCosts,
                        b: restaurants[1].sortingValues.deliveryCosts,
                        c: restaurants[2].sortingValues.deliveryCosts)
    }
    
    func testSortingProvider_whenSortedByMinimumCost_shouldBeSortedByMinimumCostInAscendingOrder() {
        restaurants.sort(by: sortingProvider.sorter(for: .minCost))
        
        XCTAssertEqual(restaurants[0].id, "1")
        XCTAssertEqual(restaurants[1].id, "2")
        XCTAssertEqual(restaurants[2].id, "3")
        assertAscending(a: restaurants[0].sortingValues.minCost,
                        b: restaurants[1].sortingValues.minCost,
                        c: restaurants[2].sortingValues.minCost)
    }
    
    private func assertAscending<T: Comparable>(a: T, b: T, c: T) {
        XCTAssertLessThanOrEqual(a, b)
        XCTAssertLessThanOrEqual(b, c)
    }
    
    private func assertDescending<T: Comparable>(a: T, b: T, c: T) {
        XCTAssertGreaterThanOrEqual(a, b)
        XCTAssertGreaterThanOrEqual(b, c)
    }
    
    private func makeRestaurants() -> [Restaurant] {
        let sortingValues1 = Restaurant.SortingValues.makeSortingValues(bestMatch: 23.1,
                                                                        newest: 1.2,
                                                                        ratingAverage: 3.5,
                                                                        distance: 445,
                                                                        popularity: 22.2,
                                                                        averageProductPrice: 434,
                                                                        deliveryCosts: 325,
                                                                        minCost: 443)
        let restaurant1 = Restaurant.makeRestaurant(id: "1", sortingValues: sortingValues1)
        
        let sortingValues2 = Restaurant.SortingValues.makeSortingValues(bestMatch: 1000,
                                                                        newest: 44,
                                                                        ratingAverage: 4.9,
                                                                        distance: 333,
                                                                        popularity: 12.1,
                                                                        averageProductPrice: 4000,
                                                                        deliveryCosts: 0,
                                                                        minCost: 599)
        let restaurant2 = Restaurant.makeRestaurant(id: "2", sortingValues: sortingValues2)
        
        let sortingValues3 = Restaurant.SortingValues.makeSortingValues(bestMatch: 11,
                                                                        newest: 1200,
                                                                        ratingAverage: 2.8,
                                                                        distance: 12,
                                                                        popularity: 55,
                                                                        averageProductPrice: 434,
                                                                        deliveryCosts: 6000,
                                                                        minCost: 1244)
        let restaurant3 = Restaurant.makeRestaurant(id: "3", sortingValues: sortingValues3)
        
        return [restaurant1, restaurant2, restaurant3]
    }
}
