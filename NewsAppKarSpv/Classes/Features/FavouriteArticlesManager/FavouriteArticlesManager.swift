//
//  FavouriteArticlesManager.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-14.
//

import Foundation

protocol FavouriteArticlesManagerInterface {
    func changeArticleState(article: ArticleEntity)
    
    func favouriteStateFor(article: ArticleEntity) -> ArticleFavouriteState
    func favouriteArticleList() -> [ArticleEntity]
}

class FavouriteArticlesManager: FavouriteArticlesManagerInterface {
    
    // MARK: - Declarations
    var onArticleFavouriteStateUpdate: (_ article: ArticleEntity, _ articleFavouriteState: ArticleFavouriteState) -> Void
    
    // MARK: - Dependencies    
    var favouriteArticlesRepository: ArticlesRepositoryInterface = FavouriteArticlesRepositoriesFactory.repository()
    var changingArticlesRepository: ArticlesRepositoryInterface = ChangingArticlesRepository.shared
    var articleApiClient: ArticleApiClientInterface = ArticleApiClient()
    var analyticsManager = AnalyticsManager.shared
    var notificationCenter = NotificationCenter.default
    
    // MARK: - Methods
    init(onArticleFavouriteStateUpdate: @escaping (_ article: ArticleEntity, _ articleFavouriteState: ArticleFavouriteState) -> Void) {
        self.onArticleFavouriteStateUpdate = onArticleFavouriteStateUpdate
        
        notificationCenter.addObserver(self,
                                       selector: #selector(didReceiveArticleFavouriteStateChanged),
                                       name: Notification.ArticleFavouriteStateChanged.name,
                                       object: nil)
    }
    
    // MARK: - Public Methods
    func changeArticleState(article: ArticleEntity) {
        guard canChangeStateFor(article: article) else {
            return
        }
        
        let newIsFavouriteState = !isFavourite(article: article)
        updateLoadingStateFor(article: article)
        
        articleApiClient.setArticleFavouriteState(
            article: article,
            favouriteStateTo: newIsFavouriteState,
            onSuccess: { (shouldBeFavourite: Bool) in
                self.updateFavouriteStateFor(article: article,
                                             state: shouldBeFavourite ? .favourite : .notFavourite)
                
            }, onError: {
                self.analyticsManager.logEvent(eventKey: .failedToChangeArticleFavouriteState)
                self.updateLoadingStateFor(article: article)
            })
    }
    
    func favouriteStateFor(article: ArticleEntity) -> ArticleFavouriteState {
        if changingArticlesRepository.articleList().contains(article) {
            return .loading
            
        } else if favouriteArticlesRepository.articleList().contains(article) {
            return .favourite
            
        } else {
            return .notFavourite
        }
    }
    
    func favouriteArticleList() -> [ArticleEntity] {
        return favouriteArticlesRepository.articleList()
    }
    
    // MARK: - State setters
    func updateFavouriteStateFor(article: ArticleEntity, state: ArticleFavouriteState) {
        favouriteArticlesRepository.updateArticleListWith(article: article)
        postArticleFavouriteStateChangedNotification(article: article, state: state)
        changingArticlesRepository.updateArticleListWith(article: article)
    }
    
    func updateLoadingStateFor(article: ArticleEntity) {
        changingArticlesRepository.updateArticleListWith(article: article)
        postArticleFavouriteStateChangedNotification(article: article, state: favouriteStateFor(article: article))
    }
    
    // MARK: - Helpers
    func isFavourite(article: ArticleEntity) -> Bool {
        return favouriteArticlesRepository.articleList().contains(article)
    }
    
    func canChangeStateFor(article: ArticleEntity) -> Bool {
        return !changingArticlesRepository.articleList().contains(article)
    }
}
