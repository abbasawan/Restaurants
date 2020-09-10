//
//  RestaurantsResponse.swift
//  Restaurants
//
//  Created by Abbas Awan on 25.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

/// The response model that is returned by restaurant list Api
struct RestaurantsResponse: Codable {
    let restaurants: [Restaurant]
}
