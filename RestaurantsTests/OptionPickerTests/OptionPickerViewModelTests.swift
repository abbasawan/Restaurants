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
    
    override func setUp() {
        super.setUp()
        
        viewModel = OptionPickerViewModel(options: RestaurantSortingType.allCases)
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
        
        XCTAssertEqual(numberOfRows, RestaurantSortingType.allCases.count)
    }
    
    func testViewModel_whenRequestedTitleForRow_shouldReturnCorrectTitle() {
        let title = viewModel.pickerViewTitle(forRow: 0, inComponent: 0)
        
        XCTAssertEqual(title, "Best Match".localized)
    }
    
    func testViewModel_whenRequestedOptionAtIndex_shouldReturnCorrectOption() {
        let option = viewModel.option(at: 0)
        
        XCTAssertEqual(option, .bestMatch)
    }
}
