//
//  CategoriesViewModel.swift
//  NewsApp
//
//  Created by skarev on 16.04.2021.
//

import RxSwift

protocol CategoriesViewModelProtocol: class {
    func fetchCategories() -> Observable<[Category]>
}

final class CategoriesViewModel: CategoriesViewModelProtocol {
    private let categories: Observable<[Category]> = Observable.of([.business, .entertainment,
                                          .general, .health, .science,
                                          .sports, .technology])

    func fetchCategories() -> Observable<[Category]> {
        categories
    }
}
