//
//  RestaurantsResponse+Mock.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 25.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

@testable import Restaurants

extension RestaurantsResponse {
    static func makeRestaurantsResponse(restaurants: [Restaurant] = [Restaurant.makeRestaurant()]) -> RestaurantsResponse {
        .init(restaurants: restaurants)
    }
}
