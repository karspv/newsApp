//
//  MockSourceListRouter.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-06.
//

import Foundation
import UIKit

// swiftlint:disable identifier_name
class MockSourceListRouter: SourceListRouterInterface {
    
    // MARK: - Declaration
    var showArticleListForSource_callCount: Int = 0
    var showArticleListForSource_source: SourceEntity?
    
    // MARK: - Methods
    func showArticleListFor(source: SourceEntity, sender: UIViewController) {
        showArticleListForSource_callCount += 1
        self.showArticleListForSource_source = source
    }
}
