//
//  ReuseIdentifiable.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

/// Protocol to help identify re-usable elements
protocol ReuseIdentifiable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    
    /// Return type name as reuseIdentifier
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
