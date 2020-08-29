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

extension Restaurant: Comparable {
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name
    }
    
    static func < (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return (lhs.status, lhs.sortingValues.bestMatch) <
            (rhs.status, rhs.sortingValues.bestMatch) // TODO: Remove bestMatch hardcoding
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
