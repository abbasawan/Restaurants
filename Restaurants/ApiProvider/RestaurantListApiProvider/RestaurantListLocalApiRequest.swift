//
//  RestaurantListLocalApiRequest.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

/// Api request to load restaurant list from local bundle
struct RestaurantListLocalApiRequest: DataRequest {
    typealias ModalType = RestaurantsResponse
    
    var path: String {
        "Restaurants"
    }
}
