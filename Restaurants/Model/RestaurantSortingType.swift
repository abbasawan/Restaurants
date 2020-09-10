//
//  RestaurantSortingType.swift
//  Restaurants
//
//  Created by Abbas Awan on 31.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

/// All types of sorting that are supported by our app
enum RestaurantSortingType: String, CaseIterable {
    case bestMatch = "Best Match"
    case newest = "Newest"
    case ratingAverage = "Rating Average"
    case distance = "Distance"
    case popularity = "Popularity"
    case averageProductPrice = "Average Price"
    case deliveryCosts = "Delivery Cost"
    case minCost = "Minimum Order"
    
    var title: String {
        rawValue.localized
    }
}
