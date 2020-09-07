//
//  OptionPickerViewModelTests.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 07.09.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import XCTest
@testable import Restaurants

final class OptionPickerViewModelTests: XCTestCase {
    private var viewModel: OptionPickerViewModel!
    private var pickerOptions: [PickerOption]!

    override func setUp() {
        super.setUp()
        pickerOptions = makePickerOptions()
        viewModel = OptionPickerViewModel(options: pickerOptions)
    }
    
    override func tearDown() {
        viewModel = nil
        
        super.tearDown()
    }
    
    func testViewModel_whenRequestedNumberOfComponents_shouldReturnOne() {
        let numberOfComponents = viewModel.pickerViewNumberOfComponents()
        
        XCTAssertEqual(numberOfComponents, 1)
    }
    
    func testViewModel_whenRequestedNumberOfRows_shouldReturnCorrectNumberOfRows() {
        let numberOfRows = viewModel.pickerViewNumberOfRows(inComponent: 0)
        
        XCTAssertEqual(numberOfRows, pickerOptions.count)
    }
    
    func testViewModel_whenRequestedTitleForRow_shouldReturnCorrectTitle() {
        let title = viewModel.pickerViewTitle(forRow: 0, inComponent: 0)
        
        XCTAssertEqual(title, pickerOptions.first?.title)
    }
    
    func testViewModel_whenRequestedOptionAtIndex_shouldReturnCorrectOption() {
        let option = viewModel.option(at: 0)
        
        XCTAssertEqual(option, pickerOptions.first?.optionKey)
    }
    
    private func makePickerOptions() -> [PickerOption] {
        RestaurantSortingType.allCases.map{ PickerOption(title: $0.title, optionKey: $0.rawValue) }
    }
}
