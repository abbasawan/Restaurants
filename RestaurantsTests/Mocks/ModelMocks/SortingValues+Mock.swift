//
//  SortingValues+Mock.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 25.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

@testable import Restaurants

extension Restaurant.SortingValues {
    static func makeSortingValues(bestMatch: Double = 0.9,
                                  newest: Double = 87,
                                  ratingAverage: Double = 4.5,
                                  distance: Int = 1100,
                                  popularity: Double = 18.1,
                                  averageProductPrice: Int = 1639,
                                  deliveryCosts: Int = 200,
                                  minCost: Int = 1000) -> Restaurant.SortingValues {
        .init(bestMatch: bestMatch, newest: newest, ratingAverage: ratingAverage, distance: distance, popularity: popularity, averageProductPrice: averageProductPrice, deliveryCosts: deliveryCosts, minCost: minCost)
    }
}
