//
//  OptionPickerView.swift
//  Restaurants
//
//  Created by Abbas Awan on 29.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit
import SnapKit

/// This class helps user pick an option from list of given options
final class OptionPickerView: UIView {
    
    // MARK - Enums and Constants
    private struct Constants {
        static let toolbarHeight: CGFloat = 44.0
    }
    
    // MARK - Public properties
    var completion: ((String) -> Void)?
    
    // MARK - Private properties
    private let viewModel: OptionPickerViewModel
    
    private lazy var actionBar: UIToolbar = {
        // If we don't pass the width while creating UIToolbar, we get a warning in the debugger.
        // So we pass the screen width to make sure when toolbar is initialized, it doesn't lay warning.
        let toolbarSize = CGSize(width: UIScreen.main.bounds.width,
                                 height: Constants.toolbarHeight)
        let bar = UIToolbar(frame: CGRect(origin: .zero, size: toolbarSize))
        addSubview(bar)
        
        bar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        let padding = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        bar.setItems([padding, doneButton], animated: false)
        
        bar.backgroundColor = .red
        return bar
    }()
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        
        addSubview(picker)
        
        picker.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(actionBar.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        picker.delegate = self
        return picker
    }()
    
    // MARK - Lifecycle
    init(viewModel: OptionPickerViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Private methods
    private func setup() {
        self.backgroundColor = .gray
        self.pickerView.dataSource = self
    }
    
    @objc private func doneButtonTapped() {
        let selectedOption = viewModel.option(at: pickerView.selectedRow(inComponent: 0))
        completion?(selectedOption)
    }
}

// MARK - UIPickerView data source methods
extension OptionPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        viewModel.pickerViewNumberOfComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.pickerViewNumberOfRows(inComponent: component)
    }
}

// MARK - UIPickerView delegate methods
extension OptionPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.pickerViewTitle(forRow: row, inComponent: component)
    }
}
