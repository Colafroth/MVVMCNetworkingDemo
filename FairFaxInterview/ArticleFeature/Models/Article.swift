//
//  Article.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 17/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation

struct ArticleCollection: Codable {
    var displayName: String
    var assets: [Article]
}

struct Article: Codable {
    var headline: String
    var theAbstract: String
    var byLine: String
    var timeStamp: Int64
    var url: String
    var relatedImages: [RelatedImage]
    var displayImageURL: URL?
}

struct RelatedImage: Codable {
    var id: Int64
    var width: Int
    var height: Int
    var url: String
}

extension RelatedImage {
    var imageSize: Int {
        return width * height
    }
}
