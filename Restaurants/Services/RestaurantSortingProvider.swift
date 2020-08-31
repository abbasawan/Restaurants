//
//  RestaurantSortingProvider.swift
//  Restaurants
//
//  Created by Abbas Awan on 30.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

protocol RestaurantSortingProvidable {
    typealias RestaurantComparator = (Restaurant, Restaurant) -> Bool
    
    func sorter(for type: RestaurantSortingType) -> RestaurantComparator
}

final class RestaurantSortingProvider {
    
    // MARK - Sorting methods
    private let bestMatch: RestaurantComparator = {
        return compare(a: ($0.status, $0.sortingValues.bestMatch),
                       b: ($1.status, $1.sortingValues.bestMatch),
                       comparator: descending)
    }
    
    private let newest: RestaurantComparator = {
        return compare(a: ($0.status, $0.sortingValues.newest),
                       b: ($1.status, $1.sortingValues.newest),
                       comparator: descending)
    }
    
    private let ratingAverage: RestaurantComparator = {
        return compare(a: ($0.status, $0.sortingValues.ratingAverage),
                       b: ($1.status, $1.sortingValues.ratingAverage),
                       comparator: descending)
    }
    
    private let distance: RestaurantComparator = {
        return compare(a: ($0.status, $0.sortingValues.distance),
                       b: ($1.status, $1.sortingValues.distance),
                       comparator: ascending)
    }
    
    private let popularity: RestaurantComparator = {
        return compare(a: ($0.status, $0.sortingValues.popularity),
                       b: ($1.status, $1.sortingValues.popularity),
                       comparator: descending)
    }
    
    private let averageProductPrice: RestaurantComparator = {
        return compare(a: ($0.status, $0.sortingValues.averageProductPrice),
                       b: ($1.status, $1.sortingValues.averageProductPrice),
                       comparator: ascending)
    }
    
    private let deliveryCosts: RestaurantComparator = {
        return compare(a: ($0.status, $0.sortingValues.deliveryCosts),
                       b: ($1.status, $1.sortingValues.deliveryCosts),
                       comparator: ascending)
    }
    
    private let minCost: RestaurantComparator = {
        return compare(a: ($0.status, $0.sortingValues.minCost),
                       b: ($1.status, $1.sortingValues.minCost),
                       comparator: ascending)
    }
    
    private static func compare<T: Comparable>(a: (status: Restaurant.Status, sortingValue: T),
                                               b: (status: Restaurant.Status, sortingValue: T),
                                               comparator: (T, T) -> Bool) -> Bool {
        if (a.status) == (b.status) {
            return comparator(a.sortingValue, b.sortingValue)
        }
        
        return ((a.status) > (b.status)) && comparator(a.sortingValue, b.sortingValue)
    }
    
    private static func descending<U: Comparable>(a: U, b: U) -> Bool {
        a > b
    }
    
    private static func ascending<U: Comparable>(a: U, b: U) -> Bool {
        a < b
    }
}

// MARK: - RestaurantSortingProvidable protocol implementation methods
extension RestaurantSortingProvider: RestaurantSortingProvidable {
    func sorter(for type: RestaurantSortingType) -> RestaurantComparator {
        switch type {
        case .bestMatch:
            return bestMatch
        case .newest:
            return newest
        case .ratingAverage:
            return ratingAverage
        case .distance:
            return distance
        case .popularity:
            return popularity
        case .averageProductPrice:
            return averageProductPrice
        case .deliveryCosts:
            return deliveryCosts
        case .minCost:
            return minCost
        }
    }
}
