//
//  ArticleEntity+Mock.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-14.
//

import Foundation

extension ArticleEntity {
    
    static func dummyMock() -> ArticleEntity {
        return ArticleEntity.mock(id: "", title: "")
    }
    
    static func mock(id: String, title: String) -> ArticleEntity {
        return ArticleEntity(id: id,
                             title: title,
                             description: "mockDescription",
                             urlToImage: URL(fileURLWithPath: "mockImageUrl"),
                             publishedDate: Date(),
                             content: "mockContent",
                             urlToArticle: URL(fileURLWithPath: "mockArticleUrl"))
    }
}
