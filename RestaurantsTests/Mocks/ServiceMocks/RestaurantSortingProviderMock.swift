//
//  RestaurantSortingProviderMock.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 31.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

@testable import Restaurants

final class RestaurantSortingProviderMock: RestaurantSortingProvidable {
    // The mock will have `ascending` bestMatch as default sorting method
    // The user of mock will set the this property according to the need
    var sortingMethod: RestaurantComparator = {
        $0.bestMatch < $1.bestMatch
    }
    
    func sorter(for type: RestaurantSortingType) -> RestaurantComparator {
        return sortingMethod
    }
}
