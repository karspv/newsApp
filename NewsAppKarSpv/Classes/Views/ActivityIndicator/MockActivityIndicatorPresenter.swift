//
//  MockActivityIndicatorPresenter.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-06.
//

import Foundation
import UIKit
@testable import NewsAppKarSpv

// swiftlint:disable identifier_name
class MockActivityIndicatorPresenter: ActivityIndicatorPresenterInterface {
    
    // MARK: - Declaration
    var activityIndicatorView: UIActivityIndicatorView?
    
    var showActivityIndicatorOn_view: UIView?
    var showActivityIndicator_callCount: Int = 0
    var hideActivityIndicator_callCount: Int = 0
    
    // MARK: - Methods
    func showActivityIndicatorOn(view: UIView) {
        showActivityIndicator_callCount += 1
        showActivityIndicatorOn_view = view
    }
    
    func hideActivityIndicator() {
        hideActivityIndicator_callCount += 1
        showActivityIndicatorOn_view = nil
    }
}
