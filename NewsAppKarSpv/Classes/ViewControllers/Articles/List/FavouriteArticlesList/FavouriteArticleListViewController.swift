//
//  FavouriteArticleListViewController.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-20.
//

import UIKit

// swiftlint:disable weak_delegate
class FavouriteArticleListViewController: BaseViewController, UISearchBarDelegate {
    
    // MARK: - Declarations
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    var tableViewDataSourceAndDelegate: ArticleListTableViewDataSourceAndDelegate?
    var dataModel: FavouriteArticleDataModelInterface!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = R.string.localizable.favourites()
        createRightBarButtonItemInNavigationBar(withSelector: #selector(didTapSortButton), title: R.string.localizable.sort())
        searchBar.setupWith(placeHolderText: R.string.localizable.searchArticleByTitleOrDescription(), controller: self)
        
        setupFor(tableView: tableView)
        
        dataModel = FavouriteArticleListDataModel(
            configuration: FavouriteArticleListDataModelConfiguration(
                onArticleUpdateFavouriteState: { [weak self] (articleIndex: Int, favouriteState: ArticleFavouriteState) in
                    self?.tableViewDataSourceAndDelegate?.updateArticleFavouriteState(index: articleIndex, newFavouriteState: favouriteState)
                },
                onArticleAddedToArticleList: { [weak self] (articleIndex: Int) in
                    self?.addArticleAt(index: articleIndex)
                },
                onArticleRemovedFromArticleList: { [weak self] (articleIndex: Int) in
                    self?.removeArticleAt(index: articleIndex)
                },
                onArticleListRearrange: { [weak self] in
                    self?.tableView.reloadData()
                }))
        
        dataModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardWillShowNotification(tableView)
        registerForKeyboardWillHideNotification(tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardShowAndHideNotificationObservers()
    }
    
    // MARK: - Setup
    func setupFor(tableView: UITableView) {
        tableView.removeEmptyCellSeparators()
        
        tableViewDelegateAndDataSourceSetup()
        
        tableView.delegate = tableViewDataSourceAndDelegate
        tableView.dataSource = tableViewDataSourceAndDelegate
    }
    
    func tableViewDelegateAndDataSourceSetup() {
        tableViewDataSourceAndDelegate = ArticleListTableViewDataSourceAndDelegate(
            tableView: tableView,
            
            articleList: { [weak self] () -> ([ArticleEntity]) in
                return self?.dataModel.articleList() ?? []
                
            }, articleFavouriteState: { [weak self] (article) -> ArticleFavouriteState in
                return (self?.dataModel.articleFavouriteState(article: article) ?? .notFavourite)
                
            }, onFavouriteButtonTapIn: { [weak self] (article) in
                self?.dataModel.changeFavouriteStateFor(article: article)
                
            }, onArticleTap: { [weak self] (article) in
                self?.showArticleDetailsFor(article: article)
            })
    }
    
    // MARK: - UI Actions
    @objc func didTapSortButton() {
        showActionSheetAlert(title: R.string.localizable.sortFavouritesBy(), actionList: actionSheetActionList())
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterArticleListBy(searchQuery: searchBar.text)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        filterArticleListBy(searchQuery: searchBar.text)
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Action Sheet
    func actionSheetActionList() -> [ActionSheetAction] {
        let sortByTitleAction = ActionSheetAction(title: R.string.localizable.sortByTitle(), didPressAction: { [weak self] in
            self?.sortArticleListBy(sortType: .title)
        })
        
        let sortByDateAction = ActionSheetAction(title: R.string.localizable.sortByDate(), didPressAction: { [weak self] in
            self?.sortArticleListBy(sortType: .date)
        })
        
        let noSortAction = ActionSheetAction(title: R.string.localizable.noSort(), didPressAction: { [weak self] in
            self?.sortArticleListBy(sortType: .none)
        })
        
        return [sortByTitleAction, sortByDateAction, noSortAction]
    }
    
    // MARK: - Sort
    func sortArticleListBy(sortType: ArticleListSortType) {
        dataModel.sortArticleListBy(sortType: sortType)
    }
    
    // MARK: - Filtering
    func filterArticleListBy(searchQuery: String?) {
        dataModel.filterArticleListBy(searchQuery: searchQuery)
    }
    
    // MARK: - Navigation
    func showArticleDetailsFor(article: ArticleEntity) {
        let viewController = ArticleDetailsViewController(article: article)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Helpers
    func removeArticleAt(index: Int) {
        guard let tableViewDataSourceAndDelegate = tableViewDataSourceAndDelegate else {
            return
        }
        tableViewDataSourceAndDelegate.updateArticleFavouriteState(index: index, newFavouriteState: .notFavourite)
        tableViewDataSourceAndDelegate.deleteTableViewRow(index: index)
    }
    
    func addArticleAt(index: Int) {
        guard let tableViewDataSourceAndDelegate = tableViewDataSourceAndDelegate else {
            return
        }
        tableViewDataSourceAndDelegate.insertRowInTableViewAt(index: index)
        tableViewDataSourceAndDelegate.updateArticleFavouriteState(index: index, newFavouriteState: .favourite)
    }
}
