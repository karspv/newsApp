//
//  UIButton+Tools.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-24.
//

import Foundation
import UIKit

// MARK: - Constants
private var kButtonCornerRadiusPercentage: CGFloat = 0.40
private var kButtonBorderWidth: CGFloat = 0.1

extension UIButton {
    
    func setupRoundCorners() {
        self.layer.cornerRadius = self.frame.height * kButtonCornerRadiusPercentage
        self.layer.borderWidth = kButtonBorderWidth
    }
}
