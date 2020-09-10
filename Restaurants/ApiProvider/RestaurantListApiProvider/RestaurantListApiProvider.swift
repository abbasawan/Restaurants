//
//  RestaurantListApiProvider.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

// MARK: - Restaurants list Api protocol
protocol RestaurantListApiProvidable {
    /// Load restaurant list
    /// - Parameter completion: Async completion block which returns either list of restaurants or error
    func loadRestaurantList(completion: @escaping (Result<[Restaurant], Error>) -> Void)
}

/// This class provides loading of restaurant list using given data service
final class RestaurantListApiProvider: RestaurantListApiProvidable {
    
    // MARK: - Private properties
    private let dataProvider: DataProvidable
    
    // MARK: - Lifecycle
    init(dataProvider: DataProvidable) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Api methods
    /// Load list of restaurants using given data service
    /// - Parameter completion: Async completion block which returns either list of restaurants or error
    func loadRestaurantList(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        let request = RestaurantListLocalApiRequest()
        dataProvider.execute(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.restaurants))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
