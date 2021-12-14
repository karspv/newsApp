//
//  ArticleDetailsContentTableViewCell.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-23.
//

import UIKit

// swiftlint:disable private_outlet
class ArticleDetailsContentTableViewCell: UITableViewCell {
    
    // MARK: - Declarations
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateWith(article: ArticleEntity) {
        contentLabel.text = article.content
    }
}
