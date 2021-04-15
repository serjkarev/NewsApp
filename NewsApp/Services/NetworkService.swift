//
//  NetworkService.swift
//  NewsApp
//
//  Created by skarev on 08.04.2021.
//

import Foundation
import RxSwift

protocol NetworkServiceProtocol {
    func fetchAllData() -> Observable<[Article]>
    func fetchTopHeadlinesData() -> Observable<[Article]>
}
// swiftlint:disable all
final class NewsNetworkService: NetworkServiceProtocol {
    private let session = URLSession.shared
    private let apiURL = "https://newsapi.org/v2/"
    private let apiKey = "f3c7c03e4aff4dbaa02e6316c98fab60"
    
    func fetchAllData() -> Observable<[Article]> {
        return Observable.create { [unowned self] observer -> Disposable in
            var components = URLComponents(string: self.apiURL + "everything?")
            components?.queryItems = [URLQueryItem(name: "apiKey", value: self.apiKey),
                                      URLQueryItem(name: "q", value: "bitcoin")]
            let task = self.session.dataTask(
                with: (components?.url)!) { data, responce, error in
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
    
    func fetchTopHeadlinesData() -> Observable<[Article]> {
        return Observable.create { [unowned self] observer -> Disposable in
            var components = URLComponents(string: self.apiURL + "top-headlines?")
            components?.queryItems = [URLQueryItem(name: "apiKey", value: self.apiKey),
                                      URLQueryItem(name: "country", value: "ua")]
            let task = self.session.dataTask(
                with: (components?.url)!) { data, responce, error in
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
