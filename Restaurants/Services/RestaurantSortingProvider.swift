//
//  RestaurantSortingProvider.swift
//  Restaurants
//
//  Created by Abbas Awan on 30.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

/// Protocol for returning a sorting function that can be used to sort list of restaurants.
protocol RestaurantSortingProvidable {
    /// Typealias for the sorting function. Takes 2 restaurants as parameter and return a Bool
    typealias RestaurantComparator = (Restaurant, Restaurant) -> Bool
    
    /// Returns restaurant sorting function for given sorting type
    /// - Parameter type: Sorting type (corresponds to sorting value of restaurant), which the
    /// function will use to compare 2 restaurants
    /// - Returns: A function that compares 2 restaurants and returns Bool result
    func sorter(for type: RestaurantSortingType) -> RestaurantComparator
}

/// This class implements `RestaurantSortingProvidable` protocol and returns sorting
/// function for the restaurants
final class RestaurantSortingProvider {
    
    // MARK - Sorting methods
    /// Returns sorting function that compares in ascending order the properties of
    /// restaurants for given keypath. It first compares restaurant status (e.g. open, closed) as
    /// high precedence before comparing the properties at keypath.
    /// - Parameter keyPath: Keypath of restaurant pointing to properties of restaurant that
    /// will be used for comparing restaurants
    /// - Returns: A function that compares 2 restaurants for given keypath and returns Bool result
    private func ascendingSorter<T: Comparable>(for keyPath: KeyPath<Restaurant, T>) -> RestaurantComparator {
    {
        self.compare(a: ($0.status, $0[keyPath: keyPath]),
                     b: ($1.status, $1[keyPath: keyPath]),
                     comparator: <)
        }
    }
    
    /// Returns sorting function that compares in descending order the properties of
    /// restaurants for given keypath. It first compares restaurant status (e.g. open, closed) as
    /// high precedence before comparing the properties at keypath.
    /// - Parameter keyPath: Keypath of restaurant pointing to properties of restaurant that
    /// will be used for comparing restaurants
    /// - Returns: A function that compares 2 restaurants for given keypath and returns Bool result
    private func descendingSorter<T: Comparable>(for keyPath: KeyPath<Restaurant, T>) -> RestaurantComparator {
    {
        self.compare(a: ($0.status, $0[keyPath: keyPath]),
                     b: ($1.status, $1[keyPath: keyPath]),
                     comparator: >)
        }
    }
    
    /// Compare restaurant status and sorting value of 2 restaurants and return a
    /// Bool result using given comparator. The Restaurant status takes precedence during comparison
    /// - Parameters:
    ///   - a: Tuple consisting of status and sorting value of first restaurant to compare
    ///   - b: Tuple consisting of status and sorting value of second restaurant to compare
    ///   - comparator: A function that will compare given sorting value of the restaurants
    /// - Returns: Bool result of comparing status and sorting value of restaurants
    private func compare<T: Comparable>(a: (status: Restaurant.Status, sortingValue: T),
                                        b: (status: Restaurant.Status, sortingValue: T),
                                        comparator: (T, T) -> Bool) -> Bool {
        // If both restaurants have same status, we need to compare their sort values and return the result
        if a.status == b.status {
            return comparator(a.sortingValue, b.sortingValue)
        }
        
        // If restaurants have different status, we need to compare the status and return the result.
        // Here we only compare the restaurant status and not the sortingValue because restaurant status
        // takes precedence over sortingValues during sorting.
        // The rank of status is like this: .open > .orderAhead > . closed
        return a.status > b.status
    }
}

// MARK: - RestaurantSortingProvidable protocol implementation methods
extension RestaurantSortingProvider: RestaurantSortingProvidable {
    /// Returns restaurant sorting function for given sorting type. The method also decides whether
    /// the sorting will be done in ascending order or descending order
    /// - Parameter type: Sorting type (corresponds to sorting value of restaurant), help decide
    /// which restaurant property will be used for sorting
    /// - Returns: A function that compares 2 restaurants and returns Bool result
    func sorter(for type: RestaurantSortingType) -> RestaurantComparator {
        switch type {
        case .bestMatch:
            // We want best matching restaurants on top so we are using descending sort
            return descendingSorter(for: \.bestMatch)
        case .newest:
            // We want newest restaurants on top so we are using descending sort
            return descendingSorter(for: \.newest)
        case .ratingAverage:
            // We want high rated restaurants on top so we are using descending sort
            return descendingSorter(for: \.ratingAverage)
        case .distance:
            // We want closest restaurants (shortest distance) on top so we are using ascending sort
            return ascendingSorter(for: \.distance)
        case .popularity:
            // We want most popular restaurants on top so we are using descending sort
            return descendingSorter(for: \.popularity)
        case .averageProductPrice:
            // We want cheaper restaurants on top so we are using ascending sort
            return ascendingSorter(for: \.averageProductPrice)
        case .deliveryCosts:
            // We want restaurants with smallest delivery costs on top so we are using ascending sort
            return ascendingSorter(for: \.deliveryCosts)
        case .minCost:
            // We want restaurants with smallest minimum order on top so we are using ascending sort
            return ascendingSorter(for: \.minCost)
        }
    }
}
