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
    @IBOutlet private weak var headlineLabel: UILabel!
    @IBOutlet private weak var theAbstractLabel: UILabel!
    @IBOutlet private weak var byLineLabel: UILabel!
    @IBOutlet private weak var sideImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func populate(with article: Article) {
        headlineLabel.text = article.headline
        theAbstractLabel.text = article.theAbstract
        byLineLabel.text = article.byLine
    }
    
}

extension ArticleTableViewCell: Reusable {}
