//
//  Restaurant.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

@dynamicMemberLookup
struct Restaurant: Codable {
    let id: String
    let name: String
    let status: Status
    let sortingValues: SortingValues
    
    subscript<T>(dynamicMember keyPath: KeyPath<SortingValues, T>) -> T {
        sortingValues[keyPath: keyPath]
    }
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

extension Restaurant.Status: Comparable {
    static func < (lhs: Restaurant.Status, rhs: Restaurant.Status) -> Bool {
        switch (lhs, rhs) {
        case (.closed, _):
            return true
        case (.orderAhead, .open):
            return true
        case (.orderAhead, .closed):
            return false
        case (.open, _):
            return false
        case (.orderAhead, .orderAhead):
            return true
        }
    }
}
