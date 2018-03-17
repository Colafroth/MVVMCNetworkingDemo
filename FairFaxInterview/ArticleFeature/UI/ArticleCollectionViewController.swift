//
//  ArticleCollectionViewController.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 15/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import UIKit

class ArticleCollectionViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        loadArticles()
    }

    private func registerCells() {
        tableView.register(ArticleTableViewCell.self)
    }

    private func loadArticles() {
        let service = Service(configuration: ServiceConfiguration.make())
        ArticleCollectionOperation().execute(in: service, onSuccess: { [weak self] articleCollection in
            guard let strongSelf = self else { return }
            print(strongSelf.articles)
            strongSelf.articles = articleCollection.assets
            strongSelf.tableView.reloadData()
        }) { error in
            print(error)
        }
    }
}

extension ArticleCollectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let article = articles[indexPath.row]
        cell.populate(with: article)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
}
