//
//  SourceListTableViewCell.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-02.
//

import UIKit

// swiftlint:disable private_outlet
class SourceListTableViewCell: UITableViewCell {
    
    // MARK: - Declarations
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var source: SourceEntity?
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateWith(source: SourceEntity) {
        reset()
        
        self.source = source
        titleLabel.text = source.title
        descriptionLabel.text = source.description
    }
    
    // MARK: - Helpers
    func reset() {
        source = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
}
