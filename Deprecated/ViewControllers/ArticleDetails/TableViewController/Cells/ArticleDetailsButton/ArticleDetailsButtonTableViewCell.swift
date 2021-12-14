//
//  ArticleDetailsButtonTableViewCell.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-23.
//

import UIKit

// swiftlint:disable private_outlet
class ArticleDetailsButtonTableViewCell: UITableViewCell {
    
    // MARK: - Declarations
    @IBOutlet weak var learnMoreButton: UIButton!
    var didTapLearnMoreButtonCompletion: (() -> Void)!
        
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        learnMoreButton.setTitle("Learn More".localized(), for: .normal)
        learnMoreButton.layer.cornerRadius = learnMoreButton.frame.height * 0.40
        learnMoreButton.layer.borderWidth = 0.1
    }
    
    // MARK: - UI actions
    @IBAction func didTapLearnMoreButton(_ sender: UIButton) {
        didTapLearnMoreButtonCompletion()
    }
}
