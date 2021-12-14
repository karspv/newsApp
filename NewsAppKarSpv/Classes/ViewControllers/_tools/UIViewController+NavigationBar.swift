//
//  UIViewController+NavigationBar.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-14.
//

import Foundation
import UIKit

extension UIViewController {
    
    func createRightBarButtonItemInNavigationBar(withSelector: Selector, title: String) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title,
                                                            style: .plain,
                                                            target: self,
                                                            action: withSelector)
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
}
