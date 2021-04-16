//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by skarev on 07.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

/*All:
 - sources
 
 TopHeadlines:
 - country ["ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "cn", "co", "cu", "cz", "de",
            "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt",
            "lv", "ma", "mx", "my", "ng", "nl", "no", "nz", "ph", "pl", "pt", "ro", "rs", "ru",
            "sa", "se", "sg", "si", "sk", "th", "tr", "tw", "ua", "us", "ve", "za"]
            //Locale.current.localizedString(forRegionCode: "jp")
 - category ["business", "entertainment", "general", "health", "science", "sports", "technology"]
 - sources
 
 */
final class NewsListViewController: UIViewController {

    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!

    private let categoryNavButton = UIBarButtonItem(title: "Category")
    private let sourceNavButton = UIBarButtonItem(title: "Source")
    private let countryNavButton = UIBarButtonItem(title: "Country")

    private let searchController = UISearchController(searchResultsController: nil)

    private let disposeBag = DisposeBag()
    var viewModel: NewsListViewModel!

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
        categoryNavButton.rx.tap.subscribe { [unowned self] _ in
            print("Category")
        }.disposed(by: disposeBag)
        sourceNavButton.rx.tap.subscribe { [unowned self] _ in
            print("Source")
        }.disposed(by: disposeBag)
        countryNavButton.rx.tap.subscribe { [unowned self] _ in
            print("Country")
        }.disposed(by: disposeBag)
        navigationItem.leftBarButtonItem = categoryNavButton
        navigationItem.rightBarButtonItems = [sourceNavButton, countryNavButton]
    }

    private func setupSearchController() {
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
        segmentedControl.rx.selectedSegmentIndex
            .subscribe(onNext: { [unowned self] index in
            switch index {
            case 0:
                self.articleType = .topHeadlines
            case 1:
                self.articleType = .all
            default:
                return
            }
            }).disposed(by: disposeBag)

        searchController.searchBar
            .rx.text
            .orEmpty
            .bind(to: viewModel.searchText)
//            .subscribe { [unowned self] query in
//                self.viewModel?.searchText.onNext(query)
//            }
            .disposed(by: disposeBag)

        viewModel?.fetchNewsViewModels(with: articleType, searchText: searchController.searchBar.text ?? "")
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
