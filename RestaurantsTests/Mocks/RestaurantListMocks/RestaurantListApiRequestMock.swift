//
//  RestaurantListApiRequestMock.swift
//  RestaurantsTests
//
//  Created by Abbas Awan on 25.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

@testable import Restaurants

struct RestaurantListApiRequestMock: DataRequest {
    typealias ModalType = RestaurantsResponse
    
    var path: String
    
    init(path: String) {
        self.path = path
    }
}
