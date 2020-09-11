//
//  RestaurantListViewController.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit
import SnapKit

/// This class shows list of restaurants, allows user filter the list by name and also sort with multiple options
final class RestaurantListViewController: UIViewController {
    
    // MARK: - Constants
    private struct Constants {
        static let tableViewEstimatedRowHeight: CGFloat = 65.0
    }
    
    // MARK: - Public properties
    /// The object that acts as the navigation delegate of restaurant list view controller
    public weak var navigationDelegate: RestaurantListViewControllerNavigationDelegate? {
        didSet {
            viewModel.navigationDelegate = navigationDelegate
        }
    }
    
    // MARK: - Private properties
    private let viewModel: RestaurantListViewModel
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        return tableView
    }()
    
    private lazy var filterOptionPicker: OptionPickerView = {
        let picker = OptionPickerView(viewModel: viewModel.sortingOptionsViewModel)
        view.addSubview(picker)
        picker.isHidden = true
        picker.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        return picker
    }()
    
    // MARK: - Lifecycle
    init(viewModel: RestaurantListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        setupNavigationBar()
        
        // Pass the selected sort option to the view model
        filterOptionPicker.completion = { [weak self] option in
            self?.filterOptionPicker.isHidden = true
            self?.viewModel.didSelectSortOption(option)
        }
        
        setupSearchController()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .taOrange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        navigationItem.rightBarButtonItem = makeFilterBarButton()
    }
    
    private func makeFilterBarButton() -> UIBarButtonItem {
        .init(title: viewModel.sortButtonTitle,
              style: .plain,
              target: self,
              action: #selector(filterButtonTapped))
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = viewModel.searchPlaceholderText
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        tableView.register(RestaurantListTableCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.tableViewEstimatedRowHeight
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func filterButtonTapped() {
        view.bringSubviewToFront(filterOptionPicker)
        filterOptionPicker.isHidden = false
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

// MARK: - RestaurantListViewModel delegate methods
extension RestaurantListViewController: RestaurantListViewModelDelegate {
    func shouldReloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            // To make sure that the reload of data happens with smooth animation, we use begin and end updates
            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
        }
    }
}

// MARK: - UISearchResultsUpdating methods
extension RestaurantListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.didChangeSearchBarText(searchController.searchBar.text)
    }
}
