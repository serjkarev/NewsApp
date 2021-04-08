//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by skarev on 08.04.2021.
//

import Foundation
import RxSwift

final class NewsListViewModel {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NewsNetworkService()) {
        self.networkService = networkService
    }
    
    func fetchNewsViewModels() -> Observable<[ArticleViewModel]> {
        networkService.fetchData().map { $0.map { ArticleViewModel(article: $0) } }
    }
}
