//
//  CategoryViewController.swift
//  NewsApp
//
//  Created by skarev on 16.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class CategoryViewController: UIViewController {

    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!

    private let categories: Observable<[Category]> = Observable.of([.business, .entertainment,
                                          .general, .health, .science,
                                          .sports, .technology])

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupButtons()
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.hideEmptyCells()

        categories
            .bind(to: tableView.rx.items(cellIdentifier: "DefaultCell")) { _, category, cell in
                cell.textLabel?.text = category.rawValue.capitalized
        }.disposed(by: disposeBag)
    }

    private func setupButtons() {
        doneButton.rx.tap.subscribe { [unowned self] _ in
            self.dismiss(animated: true)
        }.disposed(by: disposeBag)
    }
}
