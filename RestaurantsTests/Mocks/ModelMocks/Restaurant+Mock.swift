//
//  Restaurant+Mock.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 25.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

@testable import Restaurants

extension Restaurant {
    static func makeRestaurant(id: String = "1",
                               name: String = "Falafel Palace",
                               status: Status = Status(rawValue: "open")!,
                               sortingValues: SortingValues = SortingValues.makeSortingValues()) -> Restaurant {
        .init(id: id, name: name, status: status, sortingValues: sortingValues)
    }
}
