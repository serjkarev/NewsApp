//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by skarev on 07.04.2021.
//

import UIKit
import Kingfisher
import SafariServices

final class ArticleViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    @IBOutlet private weak var imageViewHeightConstraint: NSLayoutConstraint!

    var viewModel: ArticleViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setData()
    }

    private func setupNavigationBar() {
        let notificationsNavButton = UIBarButtonItem(title: "Read more",
                                                     style: .plain,
                                                     target: self,
                                                     action: #selector(readMoreButtonPressed))
        navigationItem.rightBarButtonItem = notificationsNavButton
    }

    private func setData() {
        setImage(with: viewModel?.article.urlToImage)
        titleLabel.text = viewModel?.article.title
        sourceLabel.text = viewModel?.article.author
        descriptionLabel.text = viewModel?.article.articleDescription
        dateLabel.text = viewModel?.article.publishedAt
    }

    private func setImage(with source: String?) {
        if let urlString = source, !urlString.isEmpty,
           let url = URL(string: urlString) {
            let processor = DownsamplingImageProcessor(size: imageView?.bounds.size ?? .zero)
            imageView?.kf.indicatorType = .activity
            imageView?.kf.setImage(with: url,
                                   options: [
                                    .processor(processor),
                                    .scaleFactor(UIScreen.main.scale)])
        } else {
            imageViewHeightConstraint.constant = 0
        }
    }

    @objc
    private func readMoreButtonPressed() {
        guard let urlStr = viewModel?.article.url,
              let url = URL(string: urlStr) else {
            return
        }
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
    }
}
