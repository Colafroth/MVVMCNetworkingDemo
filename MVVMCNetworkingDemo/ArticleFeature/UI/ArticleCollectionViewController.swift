//
//  ArticleCollectionViewController.swift
//  MVVMCNetworkingDemo
//
//  Created by AnTeng Lin on 15/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import UIKit

protocol ArticleCollectionViewControllerDelegate: class {
    func didTapArticle(_ article: Article)
}

class ArticleCollectionViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    weak var delegate: ArticleCollectionViewControllerDelegate?

    var viewModel: ArticleCollectionViewModel! {
        didSet {
            setupViewModel()
        }
    }

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        initStyles()
        registerCells()
        viewModel.loadArticles()
    }

    // MARK: - Private Functions
    private func initStyles() {
        tableView.backgroundColor = .lightGray
        tableView.separatorStyle = .none
    }

    private func registerCells() {
        tableView.register(ArticleTableViewCell.self)
    }

    private func setupViewModel() {
        viewModel.loadArticlesDidSuccess = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.setupNavigationBar()
            strongSelf.tableView.reloadData()
        }
    }

    private func setupNavigationBar() {
        navigationItem.title = viewModel.titleString
    }
}

// MARK: - UITableViewDelegate Conformance
extension ArticleCollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.articles[indexPath.row]
        delegate?.didTapArticle(article)
    }
}

// MARK: - UITableViewDataSource Conformance
extension ArticleCollectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let article = viewModel.articles[indexPath.row]
        cell.populate(with: article)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
}
