//
//  Router.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-06.
//

import Foundation
import UIKit

protocol SourceListRouterInterface {
    func showArticleListFor(source: SourceEntity, sender: UIViewController)
}

class SourceListRouter: SourceListRouterInterface {
    
    // MARK: - Methods
    func showArticleListFor(source: SourceEntity, sender: UIViewController) {
        let articleList = SourceArticleListViewController(source: source)
        sender.navigationController?.pushViewController(articleList, animated: true)
    }
}
