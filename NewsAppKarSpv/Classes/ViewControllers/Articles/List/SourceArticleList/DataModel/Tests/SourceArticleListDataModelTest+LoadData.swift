//
//  SourceArticleListDataModelTest+LoadData.swift
//  NewsAppKarSpvTests
//
//  Created by Karolis on 2021-04-13.
//

import XCTest
@testable import NewsAppKarSpv

extension SourceArticleListDataModelTest {
    
    // MARK: - loadData - start
    func test_loadData_triggersDataLoadingFromAPI() {
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        
        XCTAssertEqual(mockArticleApiClient.loadArticleList_callCount, 1)
    }
    
    func test_loadData_whenApiStartsDataLoading_triggersOnStartCallback() {
        var callbackCount = 0
        dataModel.loadData(onStart: { callbackCount += 1 }, onSuccess: {}, onError: {})
        XCTAssertEqual(callbackCount, 1)
    }
    
    // MARK: - loadData - finish
    func test_loadData_whenApiFinishesDataLoading_triggersOnSuccessCallback() {
        var callbackCount = 0
        
        dataModel.loadData(onStart: {}, onSuccess: { callbackCount += 1 }, onError: {})
        mockArticleApiClient.loadArticleList_onSuccess_callback?([])
        
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_loadData_whenApiFinishesDataLoading_setsArticleListFromApi() {
        let articleList: [ArticleEntity] = [ArticleEntity(id: "id3",
                                                          title: "title3",
                                                          description: "description3",
                                                          urlToImage: URL(fileURLWithPath: "iamgeUrl3"),
                                                          publishedDate: Date(),
                                                          content: "content3",
                                                          urlToArticle: URL(fileURLWithPath: "articleUrl3"))]
        
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        mockArticleApiClient.loadArticleList_onSuccess_callback?(articleList)
        
        XCTAssertEqual(dataModel.visibleArticleList, articleList)
    }
    
    // MARK: - loadData - fail
    func test_loadData_whenApiFailsDataLoading_triggersOnErrorCallback() {
        var callbackCount = 0
        
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: { callbackCount += 1 })
        mockArticleApiClient.loadArticleList_onError_callback?()
        
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_loadData_whenApiFailsDataLoading_articleListIsLeftUnchanged() {
        let articleList = [ArticleEntity(id: "id3",
                                         title: "title3",
                                         description: "description3",
                                         urlToImage: URL(fileURLWithPath: "iamgeUrl3"),
                                         publishedDate: Date(),
                                         content: "content3",
                                         urlToArticle: URL(fileURLWithPath: "articleUrl3"))]
        dataModel.visibleArticleList = articleList
        
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        mockArticleApiClient.loadArticleList_onError_callback?()
        
        XCTAssertEqual(dataModel.visibleArticleList, articleList)
    }
    
    // MARK: - Single data loading
    func test_loadData_doesNotStartDataLoadingIfOneIsInProgress() {
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        
        XCTAssertEqual(mockArticleApiClient.loadArticleList_callCount, 1)
    }
    
    func test_loadData_startsAPIRequest_ifPreviousAPIRequestIsFinished() {
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        mockArticleApiClient.loadArticleList_onSuccess_callback?([])
        mockArticleApiClient.loadArticleList_callCount = 0
        
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        
        XCTAssertEqual(mockArticleApiClient.loadArticleList_callCount, 1)
    }
}
