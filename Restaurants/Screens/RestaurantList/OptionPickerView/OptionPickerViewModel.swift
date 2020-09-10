//
//  OptionPickerViewModel.swift
//  Restaurants
//
//  Created by Abbas Awan on 29.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit

/// Option for picking. Title is for showing to user and optionKey is for returning when user
/// has finished selecting option
struct PickerOption {
    let title: String
    let optionKey: String
}

final class OptionPickerViewModel {
    
    // MARK: - Private properties
    private let options: [PickerOption]
    
    // MARK: - Lifecycle
    init(options: [PickerOption]) {
        self.options = options
    }
    
    // MARK: - Public methods
    func pickerViewNumberOfComponents() -> Int {
        1
    }
    
    func pickerViewNumberOfRows(inComponent component: Int) -> Int {
        options.count
    }
    
    func pickerViewTitle(forRow row: Int, inComponent component: Int) -> String {
        options[row].title
    }
    
    func option(at index: Int) -> String {
        options[index].optionKey
    }
}
