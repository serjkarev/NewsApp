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
 - country
 - category 
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
    var viewModel: NewsListViewModel?

    private var articleType: ArticlesType = .topHeadlines {
        didSet {
            print(articleType)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRxDependencies()
    }
}

// MARK: - Setup UI
private extension NewsListViewController {
    func setupUI() {
        setupNavigationBar()
        setupSearchController()
        setupTableView()
    }

    func setupNavigationBar() {
        navigationItem.title = "News"
        navigationItem.leftBarButtonItem = categoryNavButton
        navigationItem.rightBarButtonItems = [sourceNavButton, countryNavButton]
    }

    func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func setupTableView() {
        tableView.register(type: NewsTableViewCell.self)
    }
}

// MARK: - Setup Rx dependencies
private extension NewsListViewController {
    func setupRxDependencies() {
        rxSetupNavBarButtons()
        rxSetupSearchController()
        rxSetupSegmentControll()
        rxSetupTableViewDataModel()
        rxSetupTableViewDelegate()
    }

    func rxSetupNavBarButtons() {
        categoryNavButton.rx.tap.subscribe { [unowned self] _ in
            let viewController = CategoriesViewController.loadFromNib()
            viewController.viewModel = CategoriesViewModel()
            self.navigationController?.present(viewController, animated: true)
        }.disposed(by: disposeBag)
        sourceNavButton.rx.tap.subscribe { [unowned self] _ in
            let viewController = SourcesViewController.loadFromNib()
            viewController.viewModel = SourcesViewModel(with: NewsNetworkService())
            self.navigationController?.present(viewController, animated: true)
        }.disposed(by: disposeBag)
        countryNavButton.rx.tap.subscribe { [unowned self] _ in
            let viewController = CountriesViewController.loadFromNib()
            viewController.viewModel = CountriesViewModel()
            self.navigationController?.present(viewController, animated: true)
        }.disposed(by: disposeBag)
    }

    func rxSetupSearchController() {
        searchController.searchBar
            .rx.text
            .orEmpty
            .bind(to: viewModel!.searchText)
//            .subscribe { [unowned self] query in
//                self.viewModel?.searchText.onNext(query)
//            }
            .disposed(by: disposeBag)
    }

    func rxSetupSegmentControll() {
        segmentedControl.rx.selectedSegmentIndex
            .subscribe(onNext: { [unowned self] index in
            switch index {
            case 0:
                self.articleType = .topHeadlines
                self.countryNavButton.isEnabled = true
                self.categoryNavButton.isEnabled = true
            case 1:
                self.articleType = .all
                self.countryNavButton.isEnabled = false
                self.categoryNavButton.isEnabled = false
            default:
                return
            }
            }).disposed(by: disposeBag)
    }

    func rxSetupTableViewDataModel() {
        viewModel?.fetchNewsViewModels(with: articleType, searchText: searchController.searchBar.text ?? "")
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "\(NewsTableViewCell.self)")) { _, viewModel, cell in
            guard let cell = cell as? NewsTableViewCell else {
                return
            }
            cell.setData(viewModel)
        }.disposed(by: disposeBag)
    }

    func rxSetupTableViewDelegate() {
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
}
