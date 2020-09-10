//
//  RestaurantListTableCell.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit

/// The cell that is used to display restaurant info in the table view
final class RestaurantListTableCell: UITableViewCell {

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        // We do not need more than 2 lines for subtitle at the moment. The first line is for displaying
        // restaurant status and second line is for displaying selected sorting and sorting value of restaurant
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
