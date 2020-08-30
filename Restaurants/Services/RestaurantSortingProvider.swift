//
//  RestaurantSortingProvider.swift
//  Restaurants
//
//  Created by Abbas Awan on 30.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

protocol RestaurantSortingProvidable {
    var bestMatch: (Restaurant, Restaurant) -> Bool { get }
    var newest: (Restaurant, Restaurant) -> Bool { get }
    var ratingAverage: (Restaurant, Restaurant) -> Bool { get }
    var distance: (Restaurant, Restaurant) -> Bool { get }
    var popularity: (Restaurant, Restaurant) -> Bool { get }
    var averageProductPrice: (Restaurant, Restaurant) -> Bool { get }
    var deliveryCosts: (Restaurant, Restaurant) -> Bool { get }
    var minCost: (Restaurant, Restaurant) -> Bool { get }
}

final class RestaurantSortingProvider: RestaurantSortingProvidable {
    
    let bestMatch: (Restaurant, Restaurant) -> Bool = {
        return compare(a: ($0, $0.sortingValues.bestMatch),
                       b: ($1, $1.sortingValues.bestMatch))
    }
    
    let newest: (Restaurant, Restaurant) -> Bool = {
        return ($0.status, $0.sortingValues.newest) >
            ($1.status, $1.sortingValues.newest)
    }
    
    let ratingAverage: (Restaurant, Restaurant) -> Bool = {
        return ($0.status, $0.sortingValues.ratingAverage) >
            ($1.status, $1.sortingValues.ratingAverage)
    }
    
    let distance: (Restaurant, Restaurant) -> Bool = {
        return ($0.status, $0.sortingValues.distance) >
            ($1.status, $1.sortingValues.distance)
    }
    
    let popularity: (Restaurant, Restaurant) -> Bool = {
        return ($0.status, $0.sortingValues.popularity) >
            ($1.status, $1.sortingValues.popularity)
    }
    
    let averageProductPrice: (Restaurant, Restaurant) -> Bool = {
        return ($0.status, $0.sortingValues.averageProductPrice) >
            ($1.status, $1.sortingValues.averageProductPrice)
    }
    
    let deliveryCosts: (Restaurant, Restaurant) -> Bool = {
        return ($0.status, $0.sortingValues.deliveryCosts) >
            ($1.status, $1.sortingValues.deliveryCosts)
    }
    
    let minCost: (Restaurant, Restaurant) -> Bool = {
        return ($0.status, $0.sortingValues.minCost) >
            ($1.status, $1.sortingValues.minCost)
    }
    
    // MARK - Private methods
    private static func compare<T: Comparable>(a: (Restaurant, T),
                                               b: (Restaurant, T)) -> Bool {
        return (a.0.status, a.1) > (b.0.status, b.1)
    }
}
