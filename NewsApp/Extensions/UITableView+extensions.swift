//
//  UITableView+extensions.swift
//  NewsApp
//
//  Created by skarev on 08.04.2021.
//

import UIKit
// swiftlint:disable all
extension UITableView {
    /**
     Function to register table view cell.
     - Parameters:
     - type: type of cell.
     - bundel: cell's bundle, default initialization is nil
     */
    func register<T: UITableViewCell>(type: T.Type, bundle: Bundle? = nil) {
        let className = String(describing: type)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    /**
     Function returns cell if it was created, othrwise creates a new cell and return one.
     - Parameters:
     - type: cell's type
     - indexPath: index path of row.
     - Returns: cell.
     */
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
    }
    
    /**
     Function registers table view footer.
     - Parameters:
     - type: footer's type
     - bundel: footer's bundle, default initialization is nil
     */
    func register<T: UITableViewHeaderFooterView>(type: T.Type, bundle: Bundle? = nil) {
        let className = String(describing: type)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: type))
    }
    
    /**
    Function returns footer if it was created, othrwise creates a new footer and return one.
    - Parameters:
    - type: footer's type
    - Returns: footer view.
    */
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as! T
    }
}
// swiftlint:enable all
