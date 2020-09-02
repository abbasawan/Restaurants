//
//  RestaurantSortingProviderMock.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 31.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

@testable import Restaurants

final class RestaurantSortingProviderMock: RestaurantSortingProvidable {
    var result = false
    
    func sorter(for type: RestaurantSortingType) -> RestaurantComparator {
        return { [weak self] _, _ in
            guard let self = self else { return false }
            
            return self.result
        }
    }
}
