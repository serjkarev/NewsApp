//
//  NetworkService.swift
//  NewsApp
//
//  Created by skarev on 08.04.2021.
//

import Foundation
import RxSwift

protocol NetworkServiceProtocol {
    func fetchData() -> Observable<[Article]>
}
// swiftlint:disable all
final class NewsNetworkService: NetworkServiceProtocol {
    func fetchData() -> Observable<[Article]> {
        return Observable.create { observer -> Disposable in
            
            let task = URLSession.shared.dataTask(
                with: URL(string: "https://newsapi.org/v2/top-headlines?apiKey=f3c7c03e4aff4dbaa02e6316c98fab60&country=ua")!) { data, responce, error in
                guard let data = data else {
                    observer.onError(NSError(domain: "datat nil", code: -1, userInfo: nil))
                    return
                }
                do {
                    let news = try JSONDecoder().decode(NewsData.self, from: data)
                    observer.onNext(news.articles)
                } catch (let error) {
                    observer.onError(error)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
// swiftlint:enable all
