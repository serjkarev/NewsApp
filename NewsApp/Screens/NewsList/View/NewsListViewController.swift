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

    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!

    private let searchController = UISearchController(searchResultsController: nil)

    private let disposeBag = DisposeBag()
    var viewModel: NewsListViewModel?

    private var articleType: ArticlesType = .topHeadlines {
        didSet {
            print(articleType)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchController()
        setupTableView()
        bindViewModel()
    }

    private func setupNavigationBar() {
        navigationItem.title = "News"

        let categoriesNavButton = UIBarButtonItem(systemItem: .compose)
        categoriesNavButton.target = self
        categoriesNavButton.action = #selector(categoriesButtonPressed)

        let filtersNavButton = UIBarButtonItem(systemItem: .compose)
        filtersNavButton.target = self
        filtersNavButton.action = #selector(filtersButtonPressed)

        navigationItem.leftBarButtonItem = categoriesNavButton
        navigationItem.rightBarButtonItem = filtersNavButton
    }

    @objc
    private func categoriesButtonPressed() {
        print(#function)
    }

    @objc
    private func filtersButtonPressed() {
        print(#function)
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
// swiftlint:disable function_body_length
    private func bindViewModel() {
        segmentedControl.rx.selectedSegmentIndex.subscribe (onNext: { [unowned self] index in
            switch index {
            case 0:
                self.articleType = .topHeadlines
            case 1:
                self.articleType = .all
            default:
                return
            }
        })

        viewModel?.fetchNewsViewModels(with: articleType)
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "\(NewsTableViewCell.self)")) { _, viewModel, cell in
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

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            }).disposed(by: disposeBag)
    }
// swiftlint:enable function_body_length
}

// MARK: - UISearchResultsUpdating

extension NewsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // to do
    }
}
