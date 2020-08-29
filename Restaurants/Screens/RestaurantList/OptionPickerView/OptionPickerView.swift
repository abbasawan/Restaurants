//
//  OptionPickerView.swift
//  Restaurants
//
//  Created by Abbas Awan on 29.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit
import SnapKit

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
        let toolbarSize = CGSize(width: UIScreen.main.bounds.width,
                                 height: Constants.toolbarHeight)
        let bar = UIToolbar(frame: CGRect(origin: .zero, size: toolbarSize))
        addSubview(bar)
        
        bar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        let buffer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        bar.setItems([buffer, doneButton], animated: false)
        
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
    
    // MARK - Private functions
    private func setup() {
        self.backgroundColor = .gray
        self.pickerView.dataSource = self
    }
    
    @objc private func doneButtonTapped() {
        completion?("\(pickerView.selectedRow(inComponent: 0))")
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
        viewModel.pickerViewTitle(forRow: row, forComponent: component)
    }
}
