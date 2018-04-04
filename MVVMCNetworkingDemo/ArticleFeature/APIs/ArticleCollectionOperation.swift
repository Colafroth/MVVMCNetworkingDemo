//
//  ArticleOperation.swift
//  MVVMCNetworkingDemo
//
//  Created by AnTeng Lin on 17/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation

class ArticleCollectionOperation: JSONOperation<ArticleCollection> {
    // MARK: - Inits
    convenience init() {
        let request = Request(endpoint: "1/coding_test/13ZZQX/full")
        self.init(request: request)
    }
}
