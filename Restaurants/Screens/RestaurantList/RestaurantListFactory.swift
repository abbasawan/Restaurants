//
//  RestaurantListFactory.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit

/// This class creates restaurant list screen with all it's dependancies
final class RestaurantListFactory {

    // MARK: - Public methods
    func makeRestaurantListScreen() -> RestaurantListViewController {
        let apiProvider = AppDIContainer.shared.restaurantListApiProvider()
        let viewModel = RestaurantListViewModel(apiProvider: apiProvider)
        let controller = RestaurantListViewController(viewModel: viewModel)
        
        return controller
    }
}
