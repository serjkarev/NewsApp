//
//  CategoriesViewController.swift
//  NewsApp
//
//  Created by skarev on 16.04.2021.
//

import RxSwift

final class CategoriesViewController: UIViewController {

    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!

    var viewModel: CategoriesViewModelProtocol?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupButtons()
    }
}

// MARK: - Setup UI
private extension CategoriesViewController {
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.hideEmptyCells()

        viewModel?.fetchCategories()
            .bind(to: tableView.rx.items(cellIdentifier: "DefaultCell")) { _, category, cell in
                cell.textLabel?.text = category.rawValue.capitalized
        }.disposed(by: disposeBag)
    }

    func setupButtons() {
        doneButton.rx.tap.subscribe { [unowned self] _ in
            self.dismiss(animated: true)
        }.disposed(by: disposeBag)
    }
}
