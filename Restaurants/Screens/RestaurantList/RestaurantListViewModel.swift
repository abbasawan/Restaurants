//
//  RestaurantListViewModel.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import Foundation

// MARK: - Communication protocol
protocol RestaurantListViewModelDelegate: class {
    func shouldReloadData()
}

// MARK: - Class implementation
final class RestaurantListViewModel {
    
    // MARK: - Public properties
    let screenTitle = "Restaurant List".localized
    weak var delegate: RestaurantListViewModelDelegate?
    weak var navigationDelegate: RestaurantListViewControllerNavigationDelegate?

    // MARK: - Private properties
    private let apiProvider: RestaurantListApiProvidable
    private var restaurants: [Restaurant] = []
    private var cellViewModels: [RestaurantListTableCellViewModel] = [] {
        didSet {
            delegate?.shouldReloadData()
        }
    }
    
    // MARK: - Lifecycle
    init(apiProvider: RestaurantListApiProvidable) {
        self.apiProvider = apiProvider
    }
    
    // MARK: - Public methods
    func viewDidLoad() {
        apiProvider.loadRestaurantList { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.navigationDelegate?.show(error)
            case .success(let restaurants):
                self?.restaurants = restaurants
                self?.handleApiResponse(restaurants: restaurants)
            }
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        return cellViewModels.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> RestaurantListTableCellViewModel? {
        guard indexPath.row < cellViewModels.count else {
            return nil
        }
        
        return cellViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        // TODO: Show details
        // navigationDelegate?.showDetails(for: restaurants[indexPath.row])
    }
    
    // MARK: - Private methods
    /// Create list of table cell view models from the list of restaurants
    /// - Parameter restaurants: List of restaurants from which table cell view models will be created
    private func handleApiResponse(restaurants: [Restaurant]) {
        var cellModels = [RestaurantListTableCellViewModel]()
        for aRestaurant in restaurants {
            cellModels.append(makeCellViewModel(with: aRestaurant))
        }
        
        cellViewModels = cellModels
    }
    
    private func makeCellViewModel(with restaurant: Restaurant) -> RestaurantListTableCellViewModel {
        .init(name: restaurant.name, status: restaurant.status.rawValue)
    }
}
