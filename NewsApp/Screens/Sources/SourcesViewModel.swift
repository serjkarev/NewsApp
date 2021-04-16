//
//  SourcesViewModel.swift
//  NewsApp
//
//  Created by skarev on 16.04.2021.
//

import RxSwift

protocol SourcesViewModelProtocol: class {
    func fetchSources() -> Observable<[NewsSource]>
}

final class SourcesViewModel: SourcesViewModelProtocol {

    private let networkService: NetworkServiceProtocol

    init(with networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchSources() -> Observable<[NewsSource]> {
        networkService.fetchSources()
    }
}
