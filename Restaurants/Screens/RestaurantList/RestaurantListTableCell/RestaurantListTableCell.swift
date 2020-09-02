//
//  RestaurantListTableCell.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit

final class RestaurantListTableCell: UITableViewCell {

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.detailTextLabel?.numberOfLines = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configure(with viewModel: RestaurantListTableCellViewModel) {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.subtitle
    }
}
