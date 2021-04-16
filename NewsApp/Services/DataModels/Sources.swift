//
//  Sources.swift
//  NewsApp
//
//  Created by skarev on 16.04.2021.
//

import Foundation

// MARK: - Sources
struct Sources: Codable {
    let status: String
    let sources: [NewsSource]
}

// MARK: - NewsSource
struct NewsSource: Codable {
    let id, name, sourceDescription: String
    let url: String
    let category: Category
    let language, country: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case sourceDescription = "description"
        case url, category, language, country
    }
}

enum Category: String, Codable {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}
