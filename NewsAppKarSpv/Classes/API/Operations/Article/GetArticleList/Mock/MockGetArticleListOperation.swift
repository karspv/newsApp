//
//  MockGetArticleListOperation.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-13.
//

import Foundation

class MockGetArticleListOperation: TSMBaseOperation, GetArticleListOperationInterface {
    
    var articleListOutput: GetArticleListOutput
    var articleListInput: GetArticleListInput
    
    init(output: GetArticleListOutput, input: GetArticleListInput) {
        self.articleListOutput = output
        self.articleListInput = input
    }
    
    func output() -> GetArticleListOutput {
        return articleListOutput
    }
    
    func input() -> GetArticleListInput {
        return articleListInput
    }
}
