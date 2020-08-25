//
//  DataProvidable.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

/// Protocol for loading data from request
protocol DataProvidable {
    typealias DataCompletion<U: Decodable> = (Result<U, Error>) -> Void
    
    /// Execute the request and load data
    /// - Parameters:
    ///   - request: A request object which has path to data and the associated model type for returning
    ///   - completion: Completion block to return data/error when loading is finished
    func execute<T: DataRequest>(request: T, completion: @escaping DataCompletion<T.ModalType>)
}
