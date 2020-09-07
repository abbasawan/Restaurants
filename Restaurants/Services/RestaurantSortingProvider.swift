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
    private func ascendingSorter<T: Comparable>(for keyPath: KeyPath<Restaurant, T>) -> RestaurantComparator {
    {
        self.compare(a: ($0.status, $0[keyPath: keyPath]),
                     b: ($1.status, $1[keyPath: keyPath]),
                     comparator: self.ascending)
        }
    }
    
    private func descendingSorter<T: Comparable>(for keyPath: KeyPath<Restaurant, T>) -> RestaurantComparator {
    {
        self.compare(a: ($0.status, $0[keyPath: keyPath]),
                     b: ($1.status, $1[keyPath: keyPath]),
                     comparator: self.descending)
        }
    }
    
    private func compare<T: Comparable>(a: (status: Restaurant.Status, sortingValue: T),
                                        b: (status: Restaurant.Status, sortingValue: T),
                                        comparator: (T, T) -> Bool) -> Bool {
        if a.status == b.status {
            return comparator(a.sortingValue, b.sortingValue)
        }
        
        return a.status > b.status
    }
    
    private func descending<U: Comparable>(a: U, b: U) -> Bool {
        a > b
    }
    
    private func ascending<U: Comparable>(a: U, b: U) -> Bool {
        a < b
    }
}

// MARK: - RestaurantSortingProvidable protocol implementation methods
extension RestaurantSortingProvider: RestaurantSortingProvidable {
    func sorter(for type: RestaurantSortingType) -> RestaurantComparator {
        switch type {
        case .bestMatch:
            return descendingSorter(for: \.bestMatch)
        case .newest:
            return descendingSorter(for: \.newest)
        case .ratingAverage:
            return descendingSorter(for: \.ratingAverage)
        case .distance:
            return ascendingSorter(for: \.distance)
        case .popularity:
            return descendingSorter(for: \.popularity)
        case .averageProductPrice:
            return ascendingSorter(for: \.averageProductPrice)
        case .deliveryCosts:
            return ascendingSorter(for: \.deliveryCosts)
        case .minCost:
            return ascendingSorter(for: \.minCost)
        }
    }
}
