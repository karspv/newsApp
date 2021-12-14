//
//  ArticleListTableViewCell.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-05.
//

import UIKit
import SDWebImage

// swiftlint:disable private_outlet
class ArticleListTableViewCell: UITableViewCell {
    
    // MARK: - Declarations
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var imageAndTitleStackView: UIStackView!
    @IBOutlet weak var favouriteButton: FavouriteButton!
    
    var configuration: ArticleListTableViewCellConfiguration?
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateWith(configuration: ArticleListTableViewCellConfiguration) {
        reset()
        
        self.configuration = configuration
        
        titleLabel.text = configuration.article.title
        descriptionLabel.text = configuration.article.articleDescription
        publishDateLabel.text = DateFormatterTools.displayableStringFrom(date: configuration.article.publishDate)
        photoImageView.loadImageOrHide(imageURL: configuration.article.urlToImage)
        
        updateArticleFavouriteState(favouriteState: configuration.favouriteState)
    }
    
    func updateArticleFavouriteState(favouriteState: ArticleFavouriteState) {
        favouriteButton.set(favouriteState: favouriteState)
    }
    
    // MARK: - UI actions
    @IBAction func didTapFavouriteButton(_ sender: UIButton) {
        configuration?.onFavouriteButtonTap()
    }
    
    // MARK: - Helpers
    func reset() {
        configuration = nil
        
        titleLabel.text = nil
        descriptionLabel.text = nil
        publishDateLabel.text = nil
        photoImageView.image = nil
        favouriteButton.markAsUnFavourite()
        photoImageView.sd_cancelCurrentImageLoad()
    }
}
