//
//  ArticleApiClient.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-13.
//

import Foundation

protocol ArticleApiClientInterface {
    func loadArticleList(source: SourceEntity,
                         onSuccess: @escaping([ArticleEntity]) -> Void,
                         onError: @escaping() -> Void)
    
    func setArticleFavouriteState(article: ArticleEntity,
                                  favouriteStateTo isFavoruite: Bool,
                                  onSuccess: @escaping(_ newIsFavouriteState: Bool) -> Void,
                                  onError: @escaping() -> Void)
}

class ArticleApiClient: ArticleApiClientInterface {
    
    // MARK: - Declarations
    var operationQueue = OperationQueue()
    
    // MARK: - Methods
    deinit {
        operationQueue.cancelAllOperations()
    }
    
    func loadArticleList(source: SourceEntity,
                         onSuccess: @escaping([ArticleEntity]) -> Void,
                         onError: @escaping() -> Void) {
        let input = GetArticleListInput()
        input.source = source
        let operation = GetArticleListOperation(withInput: input)
        
        operation.completionBlock = {
            
            dispatch_main_sync_safe {
                guard operation.output.isSuccessful else {
                    print("INFO! Operation output was not successful: \(operation.output.isSuccessful)")
                    onError()
                    return
                }
                onSuccess(operation.output().articleList)
            }
        }
        self.operationQueue.addOperation(operation)
    }
    
    func setArticleFavouriteState(article: ArticleEntity,
                                  favouriteStateTo isFavourite: Bool,
                                  onSuccess: @escaping(_ newIsFavouriteState: Bool) -> Void,
                                  onError: @escaping() -> Void) {
        let input = SetArticleFavouriteStateInput(article: article, shouldBeFavourite: isFavourite)
        let operation = SetArticleFavouriteStateOperation(withInput: input)
        
        operation.completionBlock = {
            
            dispatch_main_sync_safe {
                guard operation.output.isSuccessful else {
                    print("INFO! Operation output was not successful: \(operation)")
                    onError()
                    return
                }
                onSuccess(operation.output().newFavouriteState)
            }
        }
        self.operationQueue.addOperation(operation)
    }
}
