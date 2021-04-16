//
//  CoutriesViewController.swift
//  NewsApp
//
//  Created by skarev on 16.04.2021.
//

import RxSwift

final class CountriesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var doneButton: UIButton!

    var viewModel: CountriesViewModelProtocol?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupButtons()
    }
}

// MARK: - Setup UI
private extension CountriesViewController {
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.hideEmptyCells()

        viewModel?.fetchCountries()
            .bind(to: tableView.rx.items(cellIdentifier: "DefaultCell")) { _, country, cell in
                cell.textLabel?.text = country
        }.disposed(by: disposeBag)
    }

    func setupButtons() {
        doneButton.rx.tap.subscribe { [unowned self] _ in
            self.dismiss(animated: true)
        }.disposed(by: disposeBag)
    }
}
