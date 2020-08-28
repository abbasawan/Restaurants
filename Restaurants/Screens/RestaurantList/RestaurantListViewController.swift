//
//  RestaurantListViewController.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit

final class RestaurantListViewController: UIViewController {
    
    // MARK: - Public properties
    /// The object that acts as the navigation delegate of login view controller
    public weak var navigationDelegate: RestaurantListViewControllerNavigationDelegate? {
        didSet {
            viewModel.navigationDelegate = navigationDelegate
        }
    }
    
    // MARK: - Private properties
    private let viewModel: RestaurantListViewModel
    private var tableView: UITableView!
    
    // MARK: - Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: RestaurantListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        tableView = UITableView(frame: .zero, style: .plain)
        self.view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        setup()
    }
    
    // MARK: - Private methods
    private func setup() {
        viewModel.delegate = self
        self.title = viewModel.screenTitle
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .taOrange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true

        setupSearchController()
        setupTableView()
    }
    
    private func setupSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = viewModel.searchPlaceholderText
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        tableView.register(RestaurantListTableCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
    }
}

// MARK: - Table view data source methods
extension RestaurantListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RestaurantListTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        if let cellViewModel = viewModel.cellViewModel(at: indexPath) {
            cell.configure(with: cellViewModel)
        } else {
            cell.textLabel?.text = "Error loading Restaurants data".localized
        }
        
        return cell
    }
}

// MARK: - Table view delegate methods
extension RestaurantListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension RestaurantListViewController: RestaurantListViewModelDelegate {
    func shouldReloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
        }
    }
}

extension RestaurantListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.didChangeSearchBarText(searchController.searchBar.text)
    }
}
