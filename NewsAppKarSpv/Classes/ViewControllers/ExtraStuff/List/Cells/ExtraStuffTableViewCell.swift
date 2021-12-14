//
//  ExtraStuffTableViewCell.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-27.
//

import UIKit

class ExtraStuffTableViewCell: UITableViewCell {
    
    // MARK: - Declarations
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Methods
    func populateWith(title: String) {
        reset()
        titleLabel.text = title
    }
    
    // MARK: - Helpers
    func reset() {
        titleLabel.text = nil
    }
}
