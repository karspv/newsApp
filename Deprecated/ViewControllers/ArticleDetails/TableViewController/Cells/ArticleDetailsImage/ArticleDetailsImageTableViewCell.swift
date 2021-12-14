//
//  ArticleDetailsImageTableViewCell.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-23.
//

import UIKit

// swiftlint:disable private_outlet
class ArticleDetailsImageTableViewCell: UITableViewCell {
    
    // MARK: - Declarations
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateWith(article: ArticleEntity) {
        photoImageView.loadImageOrHide(imageURL: article.urlToImage)
    }
}
