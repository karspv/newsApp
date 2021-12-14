//
//  UITableView+TSMTools.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-15.
//

import Foundation
import UIKit

extension UITableView {
    
    // MARK: - Styling methods
    public func removeEmptyCellSeparators() {
        tableFooterView = UIView()
    }
    
    // MARK: - RegisterCellNib and DequeueReusableCell Methods
    public func registerCellNib<T: UITableViewCell>(withType type: T.Type) {
        
        let identifier: String = className(fromClass: type)
        
        guard Bundle.main.path(forResource: identifier, ofType: "nib") != nil else {
            print("ERROR! Could not find NIB - \(identifier) in main bundle")
            return
        }
        
        let nib = UINib(nibName: identifier, bundle: Bundle.main)
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        
        let identifier: String = className(fromClass: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            print("ERROR! Could not dequeue cell with identifier \(identifier) for indexPath \(indexPath) ")
            return nil
        }
        
        return cell
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(withType type: T.Type = T.self) -> T? {
        // Concrete class is indicated by parameter:
        // let cell: AaaTableViewCellProtocol = tableView.dequeueReusableCell(withType: AaaTableViewCell.self)
        // If parameter is not used, class is indicated by type of variable the return value is assigned to:
        // let cell: AaaTableViewCell = tableView.dequeueReusableCell()
        
        let identifier: String = className(fromClass: type)
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T else {
            print("ERROR! Could not dequeue cell with identifier \(identifier)")
            return nil
        }
        
        return cell
    }
}
