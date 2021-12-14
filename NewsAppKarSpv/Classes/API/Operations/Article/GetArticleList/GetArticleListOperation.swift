//
//  GetArticleListOperation.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-26.
//

import Foundation

protocol GetArticleListOperationInterface: Operation {
    func output() -> GetArticleListOutput
    func input() -> GetArticleListInput
}

// swiftlint:disable force_cast
class GetArticleListOperation: TSMBaseServerOperation {
    
    // MARK: - Methods for overriding - TSMBaseOperation
    override func createOutput() -> TSMBaseOperationOutput {
        return GetArticleListOutput()
    }
    
    // MARK: - Methods for overriding - TSMBaseServerOperation
    override func urlMethodName() -> String {
        return "everything"
    }
    
    override func additionalUrlParametersDictionary() -> [String: String]? {
        guard let sourceId = input().source?.id else {
            return nil
        }
        return ["sources": sourceId]
    }
    
    override func httpMethod() -> String {
        return "GET"
    }
    
    override func additionalHeaderParametersDictionary() -> [String: String]? {
        return ["Authorization": Constants.APIOperation.key]
    }
    
    override func parseResponseDict(_ responseDict: [String: Any]) {
        guard let dictList = responseDict["articles"] as? [[String: Any]] else {
            print("ERROR! Could not create dictList from: \(responseDict)")
            return
        }
        let articleList: [ArticleEntity] = ArticleEntity.articleListFrom(dictList: dictList)
        
        output().articleList = articleList
        output.isSuccessful = true
    }
    
    // MARK: - Public - Helpers
    func output() -> GetArticleListOutput {
        return output as! GetArticleListOutput
    }
    
    func input() -> GetArticleListInput {
        return input as! GetArticleListInput
    }
}
