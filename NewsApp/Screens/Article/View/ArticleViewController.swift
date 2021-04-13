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
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var readMoreButton: UIButton!

    @IBOutlet private weak var imageViewHeightConstraint: NSLayoutConstraint!

    var viewModel: ArticleViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUIElements()
        setData()
    }

    private func setupNavigationBar() {
        let shareNavButton = UIBarButtonItem(systemItem: .action)
        shareNavButton.target = self
        shareNavButton.action = #selector(shareButtonPressed)
        navigationItem.rightBarButtonItem = shareNavButton
    }

    private func setupUIElements() {
        readMoreButton.layer.masksToBounds = true
        readMoreButton.layer.cornerRadius = readMoreButton.bounds.height / 2
    }

    private func setData() {
        navigationItem.title = viewModel?.article.author
        setImage(with: viewModel?.article.urlToImage)
        titleLabel.text = viewModel?.article.title
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
    private func shareButtonPressed() {
        guard let item = viewModel?.article.url else {
            return
        }
        let activityController = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        present(activityController, animated: true)
    }

    @IBAction private func readMoreButtonPressed(_ sender: UIButton) {
        guard let urlStr = viewModel?.article.url,
              let url = URL(string: urlStr) else {
            return
        }
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
    }
}
