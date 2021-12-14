//
//  FavouriteArticleListDataModel.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-20.
//

import Foundation

protocol FavouriteArticleDataModelInterface {
    func articleList() -> [ArticleEntity]
    func loadData()
    
    func changeFavouriteStateFor(article: ArticleEntity)
    func articleFavouriteState(article: ArticleEntity) -> ArticleFavouriteState
    
    func sortArticleListBy(sortType: ArticleListSortType)
    func filterArticleListBy(searchQuery: String?)
}

class FavouriteArticleListDataModel: FavouriteArticleDataModelInterface {
    
    // MARK: - Declarations
    var visibleArticleList: [ArticleEntity] = []
    var unchangedArticleList: [ArticleEntity] = []
    
    var currentSortType: ArticleListSortType = .none
    var currentSearchQuery: String?
    
    // Callbacks
    var onArticleUpdateFavouriteState: (_ articleIndex: Int, _ favouriteState: ArticleFavouriteState) -> Void?
    var onArticleAddedToArticleList: (_ articleIndex: Int) -> Void?
    var onArticleRemovedFromArticleList: (_ articleIndex: Int) -> Void?
    var onArticleListRearrange: () -> Void?
    
    // MARK: - Dependencies
    var articleApiClient: ArticleApiClientInterface = ArticleApiClient()
    var favouriteArticlesManager: FavouriteArticlesManagerInterface!
    var analyticsManager = AnalyticsManager.shared

    // MARK: - Methods
    init(configuration: FavouriteArticleListDataModelConfiguration) {
        self.onArticleUpdateFavouriteState = configuration.onArticleUpdateFavouriteState
        self.onArticleAddedToArticleList = configuration.onArticleAddedToArticleList
        self.onArticleRemovedFromArticleList = configuration.onArticleRemovedFromArticleList
        self.onArticleListRearrange = configuration.onArticleListRearrange
        
        favouriteArticlesManager = FavouriteArticlesManager(onArticleFavouriteStateUpdate: { [weak self]
            (article: ArticleEntity, favouriteState: ArticleFavouriteState) in
            self?.handleFavouriteStateUpdate(of: article, newState: favouriteState)
        })
    }
    
    func handleFavouriteStateUpdate(of article: ArticleEntity, newState: ArticleFavouriteState) {
        switch newState {
        case .favourite:
            if let index: Int = unchangedArticleList.firstIndex(of: article) {
                updateFavouriteStateToFavouriteAt(index: index)
            } else {
                addToArticleList(article: article)
            }
            
        case .notFavourite:
            guard unchangedArticleList.contains(article) else {
                return
            }
            removeArticleFromFavouriteArticleList(article: article)
            
        case .loading:
            guard let index: Int = visibleArticleList.firstIndex(of: article) else {
                return
            }
            onArticleUpdateFavouriteState(index, .loading)
        }
    }
    
    // MARK: - Public
    func loadData() {
        unchangedArticleList = favouriteArticlesManager.favouriteArticleList()
        updateVisibleArticleList()
    }
    
    func articleList() -> [ArticleEntity] {
        return visibleArticleList
    }
    
    // MARK: - Favourite state
    func changeFavouriteStateFor(article: ArticleEntity) {
        favouriteArticlesManager.changeArticleState(article: article)
    }
    
    func articleFavouriteState(article: ArticleEntity) -> ArticleFavouriteState {
        return favouriteArticlesManager.favouriteStateFor(article: article)
    }
    
    // MARK: - Sorting
    func sortArticleListBy(sortType: ArticleListSortType) {
        currentSortType = sortType
        updateVisibleArticleList()
        onArticleListRearrange()
        
        analyticsManager.logEvent(eventKey: .articleListSorted, withParameters: [EventParameterKeys.sortType.rawValue: sortType.rawValue])
    }
    
    // MARK: - Search bar filtering
    func filterArticleListBy(searchQuery: String?) {
        currentSearchQuery = searchQuery
        updateVisibleArticleList()
        onArticleListRearrange()
    }
    
    // MARK: - Favouriting
    func updateFavouriteStateToFavouriteAt(index: Int) {
        onArticleUpdateFavouriteState(index, .favourite)
        updateVisibleArticleList()
    }
    
    func addToArticleList(article: ArticleEntity) {
        guard unchangedArticleList.contains(article) == false else {
            return
        }
        unchangedArticleList.append(article)
        updateVisibleArticleList()
        
        guard let index: Int = visibleArticleList.firstIndex(of: article) else {
            print("ERROR! Could not get article: \(article) index from unchangedArticleList: \(unchangedArticleList) when adding")
            return
        }
        
        onArticleAddedToArticleList(index)
    }
    
    func removeArticleFromFavouriteArticleList(article: ArticleEntity) {
        guard let visibleListIndex: Int = visibleArticleList.firstIndex(of: article) else {
            print("ERROR! Could not get article: \(article) index from visibleArticleList: \(visibleArticleList) when removing")
            return
        }
        
        guard let unchangedListIndex: Int = unchangedArticleList.firstIndex(of: article) else {
            print("ERROR! Could not get article: \(article) index from unchangedArticleList: \(unchangedArticleList) when removing")
            return
        }
        
        unchangedArticleList.remove(at: unchangedListIndex)
        visibleArticleList.remove(at: visibleListIndex)
        onArticleRemovedFromArticleList(visibleListIndex)
    }
    
    private func updateVisibleArticleList() {
        let filteredArticleList = unchangedArticleList.filterBy(query: currentSearchQuery)
        visibleArticleList = filteredArticleList.sortBy(sortType: currentSortType)
    }
}
