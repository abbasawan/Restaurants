//
//  DataRequest.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

/// Protocol for determining path to the resource/data and model type for that data
protocol DataRequest {
    associatedtype ModalType: Decodable
    var path: String { get }
}
