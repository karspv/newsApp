//
//  ArticleViewModel.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-07-08.
//

import Foundation

//protocol ArticleDetailsDataModelInterface {
//    var article: ArticleEntity { get }
//
//    func changeArticleFavouriteState()
//    func articleFavouriteState() -> ArticleFavouriteState
//}

class ArticleViewModel: ObservableObject {
    
    // MARK: - Declarations
    var article: ArticleEntity
    private(set) lazy var imageUrl: URL? = article.urlToImage
    
    var buttonImageName: String {
        switch articleFavouriteState() {
        case .favourite:
            return "favourited-star"
        case .notFavourite:
            return "unfavourited-star"
        case .loading:
            return "loading-start"
        }
    }
    
    // MARK: - Dependencies
    var favouriteArticlesManager: FavouriteArticlesManagerInterface!
    
    // MARK: - Methods
    init(article: ArticleEntity) {
        self.article = article
        
        favouriteArticlesManager = FavouriteArticlesManager(onArticleFavouriteStateUpdate: { [weak self]
            (updatedArticle: ArticleEntity, favouriteState: ArticleFavouriteState) in
            guard let self = self else { return }
            
            if updatedArticle == self.article {
                self.objectWillChange.send()
            }
        })
    }
    
    // MARK: - Favourite State
    func changeArticleFavouriteState() {
        favouriteArticlesManager.changeArticleState(article: article)
    }
    
    private func articleFavouriteState() -> ArticleFavouriteState {
        return favouriteArticlesManager.favouriteStateFor(article: article)
    }
    
    func openUrl() {
        if let urlToArticle: URL = article.urlToArticle {
            urlToArticle.openUrlInExternalBrowser()
        }
    }
    
    func formatedDate() -> String {
        return DateFormatterTools.displayableStringFrom(date: article.publishDate)
    }
}
