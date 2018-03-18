//
//  ArticleCollectionViewModel.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 18/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation

typealias CompletionHandler = (() -> Void)

class ArticleCollectionViewModel {
    var articles = [Article]()
    var titleString = ""

    var loadArticlesDidComplete: CompletionHandler?

    func loadArticles() {
        let service = Service(configuration: ServiceConfiguration.make())
        ArticleCollectionOperation().execute(in: service, onSuccess: { [weak self] articleCollection in
            guard let strongSelf = self else { return }
            strongSelf.articles = strongSelf.processedArticles(articleCollection.assets)
            strongSelf.titleString = articleCollection.displayName
            strongSelf.loadArticlesDidComplete?()
        }, onError: { error in
            print(error)
        })
    }

    private func processedArticles(_ articles: [Article]) -> [Article] {
        let sortedArticles = articles.sorted { return $0.timeStamp > $1.timeStamp }
        let finalArticles = sortedArticles.map { return articleWithDisplayImageURL(from: $0) }
        return finalArticles
    }

    private func articleWithDisplayImageURL(from article: Article) -> Article {
        let articleCopy = article
        let filteredImages = article.relatedImages.filter { $0.imageSize != 0 }

        guard let urlString = filteredImages.min(by: { $0.imageSize < $1.imageSize })?.url else { return article }

        articleCopy.displayImageURL = URL(string: urlString)
        return articleCopy
    }
}
