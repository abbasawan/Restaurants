//
//  AppDIContainer.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Swinject

/// Register and resolve app dependancies
final class AppDIContainer {
    // MARK: - Public properties
    static let shared = AppDIContainer()
    
    // MARK: - Public properties
    private let container = Container()
    
    // MARK: - Lifecycle
    /// The access to initializer is private to make sure that we only have a single
    /// instance
    private init() {
        registerDependancies()
    }
    
    func restaurantListApiProvider() -> RestaurantListApiProvider {
        container.resolve(RestaurantListApiProvider.self)!
    }
    
    private func registerDependancies() {
        container.register(RestaurantListApiProvider.self) { _ in
            RestaurantListApiProvider(dataProvider: LocalDataProvider())
        }.inObjectScope(.container)
    }
}
