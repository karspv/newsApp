//
//  ArticleDetailsDataModel.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-19.
//

import Foundation

protocol ArticleDetailsDataModelInterface {
    var article: ArticleEntity { get }
    
    func changeArticleFavouriteState()
    func articleFavouriteState() -> ArticleFavouriteState
}

class ArticleDetailsDataModel: ArticleDetailsDataModelInterface {
    
    // MARK: - Declarations
    var article: ArticleEntity
    var onArticleFavouriteStateUpdate: (_ favouriteState: ArticleFavouriteState) -> Void
    
    // MARK: - Dependencies
    var favouriteArticlesManager: FavouriteArticlesManagerInterface!
    
    // MARK: - Methods
    init(article: ArticleEntity,
         onArtileFavouriteStateUpdate: @escaping (_ favouriteState: ArticleFavouriteState) -> Void) {
        self.article = article
        self.onArticleFavouriteStateUpdate = onArtileFavouriteStateUpdate
        
        favouriteArticlesManager = FavouriteArticlesManager(onArticleFavouriteStateUpdate: { [weak self]
            (updatedArticle: ArticleEntity, favouriteState: ArticleFavouriteState) in
            guard let self = self else { return }
            
            if updatedArticle == self.article {
                self.onArticleFavouriteStateUpdate(favouriteState)
            }
        })
    }
    
    // MARK: - Favourite State
    func changeArticleFavouriteState() {
        favouriteArticlesManager.changeArticleState(article: article)
    }
    
    func articleFavouriteState() -> ArticleFavouriteState {
        return favouriteArticlesManager.favouriteStateFor(article: article)
    }
}
