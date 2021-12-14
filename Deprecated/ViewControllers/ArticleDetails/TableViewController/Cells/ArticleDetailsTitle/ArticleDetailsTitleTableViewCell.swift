//
//  ArticleDetailsTitleTableViewCell.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-23.
//

import UIKit

// swiftlint:disable private_outlet
class ArticleDetailsTitleTableViewCell: UITableViewCell {
    
    // MARK: - Declarations
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateWith(article: ArticleEntity) {
        titleLabel.text = article.title
    }
}
