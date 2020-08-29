//
//  OptionPickerViewModel.swift
//  Restaurants
//
//  Created by Abbas Awan on 29.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit

final class OptionPickerViewModel {
    private let options: [String]
    
    // MARK: - Lifecycle
    init(options: [String]) {
        self.options = options
    }
    
    func pickerViewNumberOfComponents() -> Int {
        1
    }
    
    func pickerViewNumberOfRows(inComponent component: Int) -> Int {
        options.count
    }
    
    func pickerViewTitle(forRow row: Int, forComponent component: Int) -> String {
        options[row]
    }
}
