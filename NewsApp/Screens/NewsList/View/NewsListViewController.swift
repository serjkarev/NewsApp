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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupTableView()
        bindViewModel()
    }

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
    // swiftlint:disable line_length
    private func bindViewModel() {
        viewModel?.fetchNewsViewModels()
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "\(NewsTableViewCell.self)")) { index, viewModel, cell in
            guard let cell = cell as? NewsTableViewCell else {
                return
            }
            cell.setData(viewModel)
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(ArticleViewModel.self)
            .subscribe(onNext: { [weak self] viewModel in
                let viewController = ArticleViewController.loadFromNib()
                viewController.viewModel = viewModel
                self?.navigationController?.pushViewController(viewController, animated: true)
            }).disposed(by: disposeBag)
    }
    // swiftlint:enable line_length
}

// MARK: - UISearchResultsUpdating

extension NewsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // to do
    }
}
