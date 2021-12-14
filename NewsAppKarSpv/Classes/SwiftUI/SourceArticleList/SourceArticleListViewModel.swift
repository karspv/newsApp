//
//  SourceArticleListViewModel.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-07-08.
//

import Foundation
import Combine
//
//protocol SourceArticleListDataModelInterface {
//    func articleList() -> [ArticleEntity]
//    func loadData(onStart: @escaping() -> Void,
//                  onSuccess: @escaping() -> Void,
//                  onError: @escaping() -> Void)
//
//    func changeFavouriteStateFor(article: ArticleEntity)
//    func favouriteStateFor(article: ArticleEntity) -> ArticleFavouriteState
//    func filterArticleListBy(searchQuery: String?)
//}

class SourceArticleListViewModel: ObservableObject {
    
    // MARK: - Declarations
    private var source: SourceEntity
    @Published private var visibleArticleList: [ArticleEntity] = []
    var unchangedArticleList: [ArticleEntity] = []
    var isLoading: Bool = false
    
    @Published var searchText: String = ""
    private var observers: [AnyCancellable] = []
    
//    // Callbacks
//    var didUpdateArticleFavouriteState: (_ articleIndex: Int, _ favouriteState: ArticleFavouriteState) -> Void?
//    var didFilterArticleList: () -> Void?
//
    // MARK: - Dependencies
    var articleApiClient: ArticleApiClientInterface = ArticleApiClient()
    var favouriteArticlesManager: FavouriteArticlesManagerInterface!
    var analyticsManager = AnalyticsManager.shared

    // MARK: - Methods
    init(source: SourceEntity) {
        self.source = source
        
        favouriteArticlesManager = FavouriteArticlesManager(onArticleFavouriteStateUpdate: { [weak self]
            (article: ArticleEntity, favouriteState: ArticleFavouriteState) in
            self?.handleFavouriteStateChangeFor(article: article, favouriteState: favouriteState)
        })
        
        $searchText
            .sink { [weak self] searchText in
            self?.filterArticleListBy(searchQuery: searchText)
        }.store(in: &observers)
        
        loadData()
    }
    
    func loadData() {
        guard isLoading == false else {
            return
        }
        isLoading = true
        
        articleApiClient.loadArticleList(source: source, onSuccess: { [weak self] (articleList: [ArticleEntity]) in
            guard let self = self else { return }
            self.visibleArticleList = articleList
            self.unchangedArticleList = articleList
            self.isLoading = false
            self.analyticsManager.logEvent(eventKey: .articleListBecameVisible)
            
        }, onError: { [weak self] in
            self?.isLoading = false
        })
    }
    
    func sourceTitle() -> String {
        return source.title
    }
    
    func articleList() -> [ArticleEntity] {
        return visibleArticleList
    }
    
    // MARK: - Favourite State
    func changeFavouriteStateFor(article: ArticleEntity) {
        favouriteArticlesManager.changeArticleState(article: article)
    }
    
    func favouriteStateFor(article: ArticleEntity) -> ArticleFavouriteState {
        return favouriteArticlesManager.favouriteStateFor(article: article)
    }
    
    // MARK: - Search bar
    func filterArticleListBy(searchQuery: String?) {
        guard let searchQuery = searchQuery, searchQuery.isEmpty == false else {
            visibleArticleList = unchangedArticleList
            //didFilterArticleList()
            return
        }
        
        visibleArticleList = unchangedArticleList.filterBy(query: searchQuery)
        //didFilterArticleList()
    }
    
    // MARK: - Helpers
    func handleFavouriteStateChangeFor(article: ArticleEntity, favouriteState: ArticleFavouriteState) {
        guard let index: Int = visibleArticleList.firstIndex(of: article) else {
            return
        }
       // didUpdateArticleFavouriteState(index, favouriteState)
        objectWillChange.send()
    }
}
