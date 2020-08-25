//
//  RestaurantListViewControllerNavigationDelegate.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

/// Set of methods that the delegate object must implement to be notified about
/// navigation events restaurant list screen.
protocol RestaurantListViewControllerNavigationDelegate: class {
    func show(_ error: Error)
}
