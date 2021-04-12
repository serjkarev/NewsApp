//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by skarev on 08.04.2021.
//

import UIKit
import Kingfisher

final class NewsTableViewCell: UITableViewCell {

    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsDescriptionLabel: UILabel!
    @IBOutlet private weak var newsDateLabel: UILabel!

    func setData(_ viewModel: ArticleViewModel) {
//        let processor = DownsamplingImageProcessor(size: imageView?.bounds.size ?? .zero)
//        imageView?.kf.indicatorType = .activity
//        imageView?.kf.setImage(with: URL(string: viewModel.article.urlToImage),
//                               options: [
//                                .processor(processor),
//                                .scaleFactor(UIScreen.main.scale)],
//                               completionHandler: { [weak self] _ in
//                                self?.setNeedsLayout()
//                               })
        newsTitleLabel.text = viewModel.article.title
        newsDescriptionLabel.text = viewModel.article.articleDescription
        newsDateLabel.text = viewModel.article.publishedAt
    }
}
