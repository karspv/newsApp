//
//  ArticleListTableViewDataSourceAndDelegate.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-21.
//

import UIKit

class ArticleListTableViewDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Declarations
    var tableView: UITableView
    
    // MARK: - UITableViewDataSource declarations
    var articleList: () -> ([ArticleEntity])
    var articleFavouriteState: (_ article: ArticleEntity) -> (ArticleFavouriteState)
    var onFavouriteButtonTapIn: (_ article: ArticleEntity) -> Void
    
    // MARK: - UITableViewDelegate declarations
    var onArticleTap: ((_ article: ArticleEntity) -> Void)
    
    // MARK: - Methods
    init(tableView: UITableView,
         articleList: @escaping () -> ([ArticleEntity]),
         articleFavouriteState: @escaping (_ article: ArticleEntity) -> (ArticleFavouriteState),
         onFavouriteButtonTapIn: @escaping (_ article: ArticleEntity) -> Void,
         onArticleTap: @escaping ((_ article: ArticleEntity) -> Void)) {
        
        self.tableView = tableView
        self.articleList = articleList
        self.articleFavouriteState = articleFavouriteState
        self.onFavouriteButtonTapIn = onFavouriteButtonTapIn
        self.onArticleTap = onArticleTap
        
        self.tableView.registerCellNib(withType: ArticleListTableViewCell.self)
    }
    
    // MARK: - Public
    func updateArticleFavouriteState(index: Int, newFavouriteState: ArticleFavouriteState) {
        if tableView.isInViewHierarchy() {
            guard let cell: ArticleListTableViewCell = visibleCellFor(index: index) else {
                return
            }
            cell.updateArticleFavouriteState(favouriteState: newFavouriteState)
        } else {
            tableView.reloadData()
        }
    }
    
    func deleteTableViewRow(index: Int) {
        if tableView.isInViewHierarchy() && isTableViewCellVisibleAt(index: index) {
            deleteTableViewRowWith(animation: .left, at: index)
        } else {
            tableView.reloadData()
        }
    }
    
    func insertRowInTableViewAt(index: Int) {
        if tableView.isInViewHierarchy() && isTableViewCellVisibleAt(index: index) {
            insertRowInTableViewRowWith(animation: .left, at: index)
        } else {
            tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let article: ArticleEntity = articleFor(indexPath: indexPath) else {
            print("ERROR! No article for index: \(indexPath)")
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withType: ArticleListTableViewCell.self) else {
            print("ERROR! Could not dequeue tableView cell with ArticleListTableViewCell")
            return UITableViewCell()
        }
        
        let configuration = ArticleListTableViewCellConfiguration(article: article,
                                                                  favouriteState: articleFavouriteState(article),
                                                                  onFavouriteButtonTap: { [weak self] in
                                                                    self?.onFavouriteButtonTapIn(article)
                                                                  })
        cell.populateWith(configuration: configuration)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ArticleListTableViewCell,
              let article: ArticleEntity = cell.configuration?.article else {
            print("ERROR! Could not get article from cell at indexPath: \(indexPath)")
            return
        }
        
        onArticleTap(article)
    }
    
    // MARK: Helpers
    func visibleCellFor(index: Int) -> ArticleListTableViewCell? {
        let indexPath: IndexPath = indexPathFor(articleIndex: index)
        return tableView.cellForRow(at: indexPath) as? ArticleListTableViewCell
    }
    
    func isTableViewCellVisibleAt(index: Int) -> Bool {
        guard let _: ArticleListTableViewCell = visibleCellFor(index: index) else {
            return false
        }
        return true
    }
    
    func indexPathFor(articleIndex: Int) -> IndexPath {
        return IndexPath(row: articleIndex, section: 0)
    }
    
    func articleFor(indexPath: IndexPath) -> ArticleEntity? {
        return articleList()[safe: indexPath.row]
    }
    
    func deleteTableViewRowWith(animation: UITableView.RowAnimation, at index: Int) {
        tableView.performBatchUpdates {
            tableView.deleteRows(at: [indexPathFor(articleIndex: index)], with: animation)
        }
    }
    
    func insertRowInTableViewRowWith(animation: UITableView.RowAnimation, at index: Int) {
        tableView.performBatchUpdates {
            tableView.insertRows(at: [indexPathFor(articleIndex: index)], with: animation)
        }
    }
}
