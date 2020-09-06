//
//  RestaurantListApiProviderMock.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 25.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation
@testable import Restaurants

final class RestaurantListApiProviderMock: RestaurantListApiProvidable {
    private(set) var loadRestaurantListCallCount = 0

    var result: Result<[Restaurant], Error> = .failure(NetworkError.failedToLoad)
    
    func loadRestaurantList(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        loadRestaurantListCallCount += 1
        completion(result)
    }
}
