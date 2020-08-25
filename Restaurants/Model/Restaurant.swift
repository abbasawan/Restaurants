//
//  Restaurant.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

struct Restaurant: Codable {
    let id: String
    let name: String
    let status: Status
    let sortingValues: SortingValues
}

extension Restaurant {
    enum Status: String, Codable {
        case open = "open"
        case closed = "closed"
        case orderAhead = "order ahead"
    }
    
    struct SortingValues: Codable {
        let bestMatch: Double
        let newest: Double
        let ratingAverage: Double
        let distance: Int
        let popularity: Double
        let averageProductPrice: Int
        let deliveryCosts: Int
        let minCost: Int
    }
}
