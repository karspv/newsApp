//
//  UISearchBar+Tools.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-21.
//

import Foundation
import UIKit

extension UISearchBar {
    
    func setupWith(placeHolderText: String, controller: UISearchBarDelegate) {
        delegate = controller
        placeholder = placeHolderText
        showsCancelButton = true
    }
}
