//
//  NetworkError.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

/// The errors related to making network requests
enum NetworkError: Error {
    case invalidPath
    case failedToLoad
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidPath:
            return "Invalid path for resource, please contact support".localized
        case .failedToLoad:
            return "Failed to load data, please try again".localized
        }
    }
}
