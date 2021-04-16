//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by skarev on 08.04.2021.
//

import Kingfisher

final class NewsTableViewCell: UITableViewCell {

    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsDescriptionLabel: UILabel!
    @IBOutlet private weak var newsDateLabel: UILabel!

    @IBOutlet private weak var newsImageViewHeightConstraint: NSLayoutConstraint!

    func setData(_ viewModel: ArticleViewModel) {
        setImage(with: viewModel.article.urlToImage)
        newsTitleLabel.text = viewModel.article.title
        newsDescriptionLabel.text = viewModel.article.articleDescription
        newsDateLabel.text = viewModel.article.publishedAt
    }
}

// MARK: - setImage
private extension NewsTableViewCell {
    func setImage(with source: String?) {
        if let urlString = source, !urlString.isEmpty,
           let url = URL(string: urlString) {
            let processor = DownsamplingImageProcessor(size: newsImageView.bounds.size)
            newsImageView?.kf.indicatorType = .activity
            newsImageView?.kf.setImage(with: url,
                                   options: [.processor(processor),
                                             .scaleFactor(UIScreen.main.scale)])
        } else {
            newsImageViewHeightConstraint.constant = 0
        }
    }
}
