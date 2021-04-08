//
//  UIViewController+extensions.swift
//  NewsApp
//
//  Created by skarev on 07.04.2021.
//

import UIKit

extension UIViewController {
    // swiftlint:disable explicit_init
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
    // swiftlint:enable explicit_init
}
