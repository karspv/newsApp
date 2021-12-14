//
//  ActivityIndicator.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-09.
//

import Foundation
import UIKit
import PureLayout

// MARK: - Constants
private var kColorAlpha: CGFloat = 0.4

protocol ActivityIndicatorPresenterInterface {
    var activityIndicatorView: UIActivityIndicatorView? { get }
    func showActivityIndicatorOn(view: UIView)
    func hideActivityIndicator()
}

class ActivityIndicatorPresenter: ActivityIndicatorPresenterInterface {
    
    // MARK: - Declaration
    var activityIndicatorView: UIActivityIndicatorView?
    
    // MARK: - Methods
    init() {
        activityIndicatorView = initialActivityIndicatorView()
    }
    
    // MARK: - Methods
    func showActivityIndicatorOn(view: UIView) {
        hideActivityIndicator()
        
        guard let activityIndicatorView = activityIndicatorView else {
            return
        }
        
        view.addSubview(activityIndicatorView)
        view.fillWithView(view: activityIndicatorView)
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
    }
    
    func hideActivityIndicator() {
        guard let activityIndicatorView = activityIndicatorView else {
            return
        }
        
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
        activityIndicatorView.isHidden = true
    }
    
    // MARK: - Setup
    private func initialActivityIndicatorView() -> UIActivityIndicatorView {
        if let activityIndicatorView = self.activityIndicatorView {
            return activityIndicatorView
        }
        
        let activityIndicatorView: UIActivityIndicatorView = createActivityIndicatorView()
        self.activityIndicatorView = activityIndicatorView
        return activityIndicatorView
    }
    
    private func createActivityIndicatorView() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .whiteLarge)
        view.backgroundColor = UIColor.black.withAlphaComponent(kColorAlpha)
        view.hidesWhenStopped = false
        return view
    }
}
