//
//  ArticleTableViewCell.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 17/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var headlineLabel: UILabel!
    @IBOutlet private weak var theAbstractLabel: UILabel!
    @IBOutlet private weak var byLineLabel: UILabel!
    @IBOutlet private weak var sideImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        initStyles()
    }

    private func initStyles() {
        cellView.layer.cornerRadius = 10
        cellView.clipsToBounds = true
        headlineLabel.font = UIFont(name: "Helvetica", size: 20)
        theAbstractLabel.font = UIFont(name: "Helvetica", size: 16)
        byLineLabel.font = UIFont(name: "Helvetica", size: 14)
    }

    func populate(with article: Article) {
        headlineLabel.text = article.headline
        theAbstractLabel.text = article.theAbstract
        byLineLabel.text = article.byLine
        guard let url = article.displayImageURL else { return }
        sideImageView.kf.setImage(with: url)
    }
}

extension ArticleTableViewCell: Reusable {}
