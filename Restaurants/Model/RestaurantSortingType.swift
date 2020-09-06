//
//  RestaurantSortingType.swift
//  Restaurants
//
//  Created by Abbas Awan on 31.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

enum RestaurantSortingType: CaseIterable {
    case bestMatch
    case newest
    case ratingAverage
    case distance
    case popularity
    case averageProductPrice
    case deliveryCosts
    case minCost
}
