//
//  CoutriesViewController.swift
//  NewsApp
//
//  Created by skarev on 16.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class CountriesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var doneButton: UIButton!

    private let disposeBag = DisposeBag()

    private let sources: Observable<[Country]> = Observable.of([.ae, .ar, .at, .au, .be, .bg, .br, .ca, .ch,
                                                               .cn, .co, .cu, .cz, .de, .eg, .fr, .gb, .gr,
                                                               .hk, .hu, .id, .ie, .il, .`in`, .it, .jp, .kr,
                                                               .lt, .lv, .ma, .mx, .my, .ng, .nl, .no, .nz,
                                                               .ph, .pl, .pt, .ro, .rs, .ru, .sa, .se, .sg,
                                                               .si, .sk, .th, .tr, .tw, .ua, .us, .ve, .za])

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupButtons()
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.hideEmptyCells()

        sources
            .bind(to: tableView.rx.items(cellIdentifier: "DefaultCell")) { _, category, cell in
                cell.textLabel?.text = Locale.current.localizedString(forRegionCode: category.rawValue)
        }.disposed(by: disposeBag)
    }

    private func setupButtons() {
        doneButton.rx.tap.subscribe { [unowned self] _ in
            self.dismiss(animated: true)
        }.disposed(by: disposeBag)
    }

}
