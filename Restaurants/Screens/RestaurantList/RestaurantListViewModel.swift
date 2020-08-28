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
    let searchPlaceholderText = "Type Restaurant name".localized
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
                self?.prepareCellViewModel(from: restaurants)
            }
        }
    }
    
    func didChangeSearchBarText(_ text: String?) {
        guard let searchText = text else {
            return
        }
        
        print(searchText)
        filterRestaurantList(for: searchText)
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
    private func prepareCellViewModel(from restaurants: [Restaurant]) {
        var cellModels = [RestaurantListTableCellViewModel]()
        for aRestaurant in restaurants {
            cellModels.append(makeCellViewModel(with: aRestaurant))
        }
        
        if cellModels != cellViewModels {
            cellViewModels = cellModels
        }
    }
    
    /// Creates and returns cell view model from a restaurant object
    /// - Parameter restaurant: restaurant object from which to create cell view model
    /// - Returns: Cell view model to be displayed in the list
    private func makeCellViewModel(with restaurant: Restaurant) -> RestaurantListTableCellViewModel {
        .init(name: restaurant.name, status: restaurant.status.rawValue)
    }
    
    /// Filter the restaurants if their name contains the search term and
    /// update the cell view models array so that latest result can be
    /// displayed to the user
    /// - Parameter name: Name for which we need to filter the restaurant list
    private func filterRestaurantList(for name: String) {
        guard !name.isEmpty else {
            self.prepareCellViewModel(from: restaurants)
            return
        }
        
        let filtered = restaurants.filter({
            $0.name.lowercased().contains(name.lowercased())
        })
        self.prepareCellViewModel(from: filtered)
    }
}
