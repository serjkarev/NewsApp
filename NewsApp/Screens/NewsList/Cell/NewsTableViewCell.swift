//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by skarev on 08.04.2021.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {

    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsDescriptionLabel: UILabel!
    @IBOutlet private weak var newsDateLabel: UILabel!

    func setData(_ viewModel: ArticleViewModel) {
//        newsImageView.image =
        newsTitleLabel.text = viewModel.article.title
        newsDescriptionLabel.text = viewModel.article.articleDescription
        newsDateLabel.text = viewModel.article.publishedAt
    }
}
