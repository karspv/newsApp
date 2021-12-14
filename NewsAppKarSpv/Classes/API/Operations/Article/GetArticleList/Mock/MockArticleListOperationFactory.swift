//
//  MockArticleListOperationFactory.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-13.
//

import Foundation

protocol ArticleListOperationFactoryInterface {
    func operation() -> GetArticleListOperationInterface
}

// swiftlint:disable identifier_name
class MockArticleListOperationFactory: ArticleListOperationFactoryInterface {
    
    var mockOperationList: [MockGetArticleListOperation] = []
    
    var mockGetArticleListOperation = MockGetArticleListOperation(output: GetArticleListOutput(), input: GetArticleListInput())
    var operation_callCount: Int = 0
    
    func operation() -> GetArticleListOperationInterface {
        if operation_callCount < mockOperationList.count {
            operation_callCount += 1
            return mockOperationList[operation_callCount - 1]
        } else {
            operation_callCount += 1
            return mockGetArticleListOperation
        }
    }
}
