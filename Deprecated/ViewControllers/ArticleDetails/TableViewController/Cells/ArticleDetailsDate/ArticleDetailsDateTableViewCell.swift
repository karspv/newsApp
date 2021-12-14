//
//  ArticleDetailsDateTableViewCell.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-23.
//

import UIKit

// swiftlint:disable private_outlet
class ArticleDetailsDateTableViewCell: UITableViewCell {
    
    // MARK: - Declarations
    @IBOutlet weak var publishDateLabel: UILabel!
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateWith(article: ArticleEntity) {
        publishDateLabel.text = DateFormatterTools.displayableStringFrom(date: article.publishDate)
    }
}
