//
//  ArticleDetailsDescriptionTableViewCell.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-23.
//

import UIKit

// swiftlint:disable private_outlet
class ArticleDetailsDescriptionTableViewCell: UITableViewCell {
    
    // MARK: - Declarations
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateWith(article: ArticleEntity) {
        descriptionLabel.text = article.description
    }
}
