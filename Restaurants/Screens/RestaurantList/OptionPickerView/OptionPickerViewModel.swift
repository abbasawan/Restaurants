//
//  OptionPickerViewModel.swift
//  Restaurants
//
//  Created by Abbas Awan on 29.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit

final class OptionPickerViewModel {
    private let options: [RestaurantSortingType]
    
    // MARK: - Lifecycle
    init(options: [RestaurantSortingType]) {
        self.options = options
    }
    
    func pickerViewNumberOfComponents() -> Int {
        1
    }
    
    func pickerViewNumberOfRows(inComponent component: Int) -> Int {
        options.count
    }
    
    func pickerViewTitle(forRow row: Int, inComponent component: Int) -> String {
        switch options[row] {
        case .bestMatch:
            return "Best Match".localized
        case .newest:
            return "Newest".localized
        case .ratingAverage:
            return "Rating Average".localized
        case .distance:
            return "Distance".localized
        case .popularity:
            return "Popularity".localized
        case .averageProductPrice:
            return "Average Price".localized
        case .deliveryCosts:
            return "Delivery Cost".localized
        case .minCost:
            return "Minimum Order".localized
        }
    }
    
    func option(at index: Int) -> RestaurantSortingType {
        options[index]
    }
}
