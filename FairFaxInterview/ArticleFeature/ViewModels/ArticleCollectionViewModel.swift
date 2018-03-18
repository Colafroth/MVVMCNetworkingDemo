//
//  ArticleCollectionViewModel.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 18/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation

typealias SuccessHandler = (() -> Void)
typealias FailureHandler = ((Error) -> Void)

class ArticleCollectionViewModel {
    // MARK: - Properties
    var articles = [Article]()
    var titleString = ""

    var loadArticlesDidSuccess: SuccessHandler?
    var loadArticlesDidFail: FailureHandler?

    // MARK: - Public Functions
    func loadArticles(operation: JSONOperation<ArticleCollection> = ArticleCollectionOperation()) {
        let service = Service(configuration: ServiceConfiguration.make())
        operation.execute(in: service, onSuccess: { [weak self] articleCollection in
            guard let strongSelf = self else { return }
            strongSelf.articles = strongSelf.processedArticles(articleCollection.assets)
            strongSelf.titleString = articleCollection.displayName
            strongSelf.loadArticlesDidSuccess?()
        }, onError: { [weak self] error in
            self?.loadArticlesDidFail?(error)
        })
    }

    // MARK: - Private Functions
    private func processedArticles(_ articles: [Article]) -> [Article] {
        let sortedArticles = articles.sorted { return $0.timeStamp > $1.timeStamp }
        let finalArticles = sortedArticles.map { return articleWithDisplayImageURL(from: $0) }
        return finalArticles
    }

    private func articleWithDisplayImageURL(from article: Article) -> Article {
        var articleCopy = article
        let filteredImages = article.relatedImages.filter { $0.imageSize != 0 }

        guard let urlString = filteredImages.min(by: { $0.imageSize < $1.imageSize })?.url else { return article }

        articleCopy.displayImageURL = URL(string: urlString)
        return articleCopy
    }
}
