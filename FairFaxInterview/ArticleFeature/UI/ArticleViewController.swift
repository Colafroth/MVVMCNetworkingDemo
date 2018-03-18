//
//  ArticleViewController.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 18/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ArticleViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var webView: WKWebView!

    // MARK: - Properties
    var viewModel: ArticleViewModel!

    // MARK: - Life Cycles
    override func viewWillAppear(_ animated: Bool) {
        webView.load(URLRequest(url: viewModel.articleURL))
    }
}
