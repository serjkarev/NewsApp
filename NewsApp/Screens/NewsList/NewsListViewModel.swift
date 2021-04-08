//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by skarev on 08.04.2021.
//

import Foundation

final class NewsListViewModel {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
