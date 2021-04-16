//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by skarev on 08.04.2021.
//

import Foundation
import RxSwift
import RxCocoa

enum ArticlesType {
    case all
    case topHeadlines
}

final class NewsListViewModel {

    private let networkService: NetworkServiceProtocol
    private let disposeBag = DisposeBag()
    
    var searchText = PublishSubject<String>()
//    var newsData = Observable<[ArticleViewModel]>()
    
    init(networkService: NetworkServiceProtocol = NewsNetworkService()) {
        self.networkService = networkService
        self.setup()
    }
    
    private func setup() {
        searchText.asObserver()
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe { [unowned self] text in
                self.fetchNewsViewModels(with: .all, searchText: text)
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { articleViewModel in
                        print(articleViewModel.count)
                }).disposed(by: disposeBag)
            }.disposed(by: disposeBag)
    }
    
    func fetchNewsViewModels(with type: ArticlesType, searchText: String) -> Observable<[ArticleViewModel]> {
        switch type {
        case .all:
            return networkService.fetchAllData(with: searchText).map { $0.map { ArticleViewModel(article: $0) } }
        case .topHeadlines:
            return networkService.fetchTopHeadlinesData().map { $0.map { ArticleViewModel(article: $0) } }
        }
    }
}
