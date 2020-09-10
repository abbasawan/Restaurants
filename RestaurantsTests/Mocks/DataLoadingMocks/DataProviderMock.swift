//
//  DataProviderMock.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 25.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation
@testable import Restaurants

/// A class that universally converts any Encodable object to response type of data request
final class DataProviderMock<U: Encodable>: DataProvidable {
    
    var result: Result<U, Error> = .failure(NetworkError.failedToLoad)
    
    // This method will convert input type to Data, and then try to convert back to output type
    func execute<T>(request: T, completion: @escaping (Result<T.ModalType, Error>) -> Void) where T : DataRequest {
        
        switch result {
        case .failure(let error):
            completion(.failure(error))
            
        case .success(let model):
            let result: Result<T.ModalType, Error>
            do {
                let jsonData = try JSONEncoder().encode(model)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.ModalType.self, from: jsonData)
                result = .success(decodedData)
            } catch let parsingError {
                result = .failure(parsingError)
            }
            
            completion(result)
        }
    }
}
