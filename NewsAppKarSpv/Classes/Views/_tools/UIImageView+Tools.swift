//
//  UIImageView+Tools.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-22.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImageOrHide(imageURL: URL?) {
        guard let image = imageURL else {
            isHidden = true
            return
        }
        isHidden = false
        sd_setImage(with: image)
    }
}
