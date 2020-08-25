//
//  String+Util.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

extension String {
    /// Returns localized string of self as a key
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
