//
//  UIScrollView+Tools.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-11.
//

import Foundation
import UIKit

extension UIScrollView {
    
    func setContentAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
        contentInset = edgeInsets
        scrollIndicatorInsets = edgeInsets
    }
}
