//
//  ArticleDetailsViewControllerWithTableView.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-22.
//

import UIKit

// swiftlint:disable private_outlet
class ArticleDetailsViewControllerWithTableView: UIViewController, UITableViewDataSource {
    
    // MARK: - Declarations
    @IBOutlet weak var tableView: UITableView!
    
    var dataModel: ArticleDetailsDataModelInterface!
    
    // MARK: - Methods
    init(article: ArticleEntity) {
        super.init(nibName: nil, bundle: nil)
        
        dataModel = ArticleDetailsDataModel(article: article)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = dataModel.article.title
        registerTableViewCells()
        tableView.removeEmptyCellSeparators()
    }
    
    // MARK: - Helpers
    func openArticleInBrowser() {
        
        if let urlToArticle: URL = dataModel.article.urlToArticle {
            urlToArticle.openUrlInExternalBrowser()
        }
    }
}
