//
//  LocalDataProvider.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

/// This class loads data from local source i.e. application bundle
final class LocalDataProvider: DataProvidable {
    
    /// Execute the request and load and return data from bundle
    /// - Parameters:
    ///   - request: A request object which has path to local data and the associated model type for returning
    ///   - completion: Completion block to return data/error when loading is finished
    func execute<T: DataRequest>(request: T, completion: @escaping DataCompletion<T.ModalType>) {
        guard let bundlePath = Bundle.main.path(forResource: request.path, ofType: "json") else {
            completion(.failure(NetworkError.invalidPath))
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: bundlePath), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let returnData = try decoder.decode(T.ModalType.self, from: data)
            completion(.success(returnData))
        } catch let parsingError {
            completion(.failure(parsingError))
        }
    }
}
