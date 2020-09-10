//
//  Restaurant.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

/// Restaurant object represents values associated with every restaurant
@dynamicMemberLookup
struct Restaurant: Codable {
    let id: String
    let name: String
    let status: Status
    let sortingValues: SortingValues
    
    /// We use dynamic member lookup to look for and return sorting values related to restaurant.
    /// This simplifies the code, makes code smaller and easier to read
    subscript<T>(dynamicMember keyPath: KeyPath<SortingValues, T>) -> T {
        sortingValues[keyPath: keyPath]
    }
}

// MARK: - Restaurant sub types
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

// MARK: - Restaurant Status `Comparable` protocol implementation
extension Restaurant.Status: Comparable {
    static func < (lhs: Restaurant.Status, rhs: Restaurant.Status) -> Bool {
        switch (lhs, rhs) {
        case (.closed, _):
            // .closed status has the least priority, so this means .closed will be less than any other value
            return true
        case (.orderAhead, .open):
            // .orderAhead has less priority than .open status, so we return true
            return true
        case (.orderAhead, .closed):
            // .orderAhead has higher priority than .closed status, so we return false
            return false
        case (.open, _):
            // .open status has the highest priority, so this means .open will be higher than any other value
            return false
        case (.orderAhead, .orderAhead):
            // .orderAhead is actually equal to .orderAhead. We need to have this case because `switch`
            // needs to be exhaustive. Returning both true and false here has same effect in our case.
            return true
        }
    }
}
