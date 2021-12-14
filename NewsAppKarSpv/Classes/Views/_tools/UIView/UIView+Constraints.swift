//
//  UIView+Tools.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-17.
//

import Foundation
import UIKit

extension UIView {
    
    // MARK: - Constraints setup
    func fillWithView(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autoPinEdgesToSuperviewEdges()
    }
    
    func setupViewFrameWith(width: CGFloat, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
