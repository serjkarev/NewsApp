//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by skarev on 07.04.2021.
//

import UIKit

final class AppCoordinator {
    
    private let window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = NewsListViewController.loadFromNib()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
