//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by skarev on 07.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class NewsListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let searchController = UISearchController(searchResultsController: nil)
    
    private let disposeBag = DisposeBag()
    var viewModel: NewsListViewModel?

    // swiftlint:disable line_length
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupTableView()
        viewModel?.fetchNewsViewModels().observe(on: MainScheduler.instance).bind(to: tableView.rx.items(cellIdentifier: "\(NewsTableViewCell.self)")) { index, viewModel, cell in
            guard let cell = cell as? NewsTableViewCell else {
                return
            }
            cell.setData(viewModel)
        }.disposed(by: disposeBag)
    }
    // swiftlint:enable line_length
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func setupTableView() {
        tableView.register(type: NewsTableViewCell.self)
    }
}

// MARK: - UISearchResultsUpdating

extension NewsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // to do
    }
}
/*
// MARK: - UITableViewDelegate

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: NewsTableViewCell.self, for: indexPath)
         cell.setData()
        return cell
    }
}
*/
