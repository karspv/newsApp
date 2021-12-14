//
//  ArticleDetailsViewController.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-19.
//

import UIKit

class ArticleDetailsViewController: UIViewController {
    
    // MARK: - Declarations
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var publishDateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var learnMoreButton: UIButton!
    @IBOutlet private weak var favouriteButton: FavouriteButton!
    
    var dataModel: ArticleDetailsDataModelInterface!
    
    // MARK: - Methods
    init(article: ArticleEntity) {
        super.init(nibName: nil, bundle: nil)
        dataModel = ArticleDetailsDataModel(article: article, onArtileFavouriteStateUpdate: { [weak self]
            (favouriteState: ArticleFavouriteState) in
            self?.updateFavouriteButton(favouriteState: favouriteState)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = dataModel.article.title
        setupViewsFor(article: dataModel.article)
        
        learnMoreButton.setTitle(R.string.localizable.learnMore(), for: .normal)
        learnMoreButton.setupRoundCorners()
        
        updateFavouriteButton(favouriteState: dataModel.articleFavouriteState())
    }
    
    // MARK: - Setup
    func setupViewsFor(article: ArticleEntity) {
        publishDateLabel.text = DateFormatterTools.displayableStringFrom(date: article.publishDate)
        titleLabel.text = article.title
        photoImageView.loadImageOrHide(imageURL: article.urlToImage)
        descriptionLabel.text = article.articleDescription
        contentLabel.text = article.content
    }
    
    func updateFavouriteButton(favouriteState: ArticleFavouriteState) {
        favouriteButton.set(favouriteState: favouriteState)
    }
    
    // MARK: - UI actions
    @IBAction func didTapLearnMoreButton(_ sender: UIButton) {
        if let urlToArticle: URL = dataModel.article.urlToArticle {
            urlToArticle.openUrlInExternalBrowser()
        }
    }
    
    @IBAction func didTapFavouriteButton(_ sender: UIButton) {
        dataModel.changeArticleFavouriteState()
    }
    
    // MARK: - Screen rotation
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
