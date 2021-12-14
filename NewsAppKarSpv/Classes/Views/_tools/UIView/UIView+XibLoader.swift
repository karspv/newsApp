//
//  UIView+XibLoader.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-31.
//

import Foundation
import UIKit

extension UIView {
    
    // MARK: - UIView XibLoader
    class func loadXib(ofClass aClass: AnyClass,
                       prefix: String = "",
                       suffix: String = "",
                       bundle: Bundle? = nil) -> UIView? {
        
        let nibName: String = String(describing: aClass)
        let fullNibName: String = prefix.appending(nibName).appending(suffix)
        let nib: UINib = UINib(nibName: fullNibName, bundle: bundle)
        let view: UIView? = nib.instantiate(withOwner: nil, options: nil).first as? UIView
        
        return view
    }
    
    func loadXibFromClass(_ aClass: AnyClass) -> UIView? {
        guard let xibFromClass = Bundle.main.loadNibNamed(String(describing: aClass), owner: nil, options: nil)?.first as? UIView else {
            print("ERROR! Could not load xib named \(aClass)")
            return nil
        }
        
        return xibFromClass
    }
}
