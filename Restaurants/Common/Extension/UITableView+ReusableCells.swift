//
//  UITableView+ReusableCells.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit

extension UITableViewCell: ReuseIdentifiable {}

/// Helper methods for easy cell registering and dequeuing.
/// It also helps us avoid type casting to custom cell classes.
extension UITableView {
    /// Register table cell with the table view
    /// - Parameter cells: List of cell classes to be registered with table cells
    func register(_ cells: UITableViewCell.Type...) {
        cells.forEach{ register($0, forCellReuseIdentifier: $0.reuseIdentifier) }
    }
    
    /// Dequeue table cell for given type
    /// - Parameter indexPath: Index path for which the cell is to be dequeued
    /// - Returns: Returns the table cell of given type. If not found, the default table cell is returned
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            return T(style: .default, reuseIdentifier: T.reuseIdentifier)
        }
        
        return cell
    }
}
