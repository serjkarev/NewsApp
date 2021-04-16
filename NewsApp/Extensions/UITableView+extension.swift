//
//  UITableView+extension.swift
//  NewsApp
//
//  Created by skarev on 16.04.2021.
//

import UIKit

extension UITableView {
    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }
}
