//
//  ArticleCollectionCoordinator.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 18/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ArticleCollectionCoordinator: Coordinatable {
    var childCoordinators = [Coordinatable]()
    var rootViewController: UINavigationController!
    var articleCollectionViewController: ArticleCollectionViewController!

    func start() {
        let articleCollectionViewController: ArticleCollectionViewController = UIStoryboard(storyboard: .main).instantiateViewController()
        self.articleCollectionViewController = articleCollectionViewController
        self.articleCollectionViewController.delegate = self
        self.articleCollectionViewController.viewModel = ArticleCollectionViewModel()
        rootViewController = UINavigationController(rootViewController: articleCollectionViewController)
    }
}

extension ArticleCollectionCoordinator: ArticleCollectionViewControllerDelegate {
    func didTapArticle(_ article: Article) {
        guard let url = URL(string: article.url) else { return }
        let articleViewController: ArticleViewController = UIStoryboard(storyboard: .main).instantiateViewController()
        articleViewController.viewModel = ArticleViewModel(articleURL: url)
        rootViewController.pushViewController(articleViewController, animated: true)
    }
}
