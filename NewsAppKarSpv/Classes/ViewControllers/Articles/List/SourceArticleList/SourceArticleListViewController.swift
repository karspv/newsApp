//
//  ArticleListViewController.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-05.
//

import UIKit

// swiftlint:disable weak_delegate
class SourceArticleListViewController: BaseViewController, UISearchBarDelegate {
    
    // MARK: - Declarations
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    var tableViewDataSourceAndDelegate: ArticleListTableViewDataSourceAndDelegate?
    
    var dataModel: SourceArticleListDataModelInterface!
    
    var activityIndicatorView: ActivityIndicatorPresenterInterface = ActivityIndicatorPresenter()
    var refreshControl = UIRefreshControl()
    
    // MARK: - Methods
    init(source: SourceEntity) {
        super.init(nibName: nil, bundle: nil)
        
        title = source.title
        dataModel = SourceArticleListDataModel(
            source: source,
            onArticleListFiltered: { [weak self] in
                self?.tableView.reloadData()
            },
            onArticleFavouriteStateUpdate: { [weak self] (articleIndex: Int, favouriteState: ArticleFavouriteState) in
                self?.tableViewDataSourceAndDelegate?.updateArticleFavouriteState(index: articleIndex, newFavouriteState: favouriteState)
            })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(tableView: tableView)
        searchBar.setupWith(placeHolderText: R.string.localizable.searchArticleByTitleOrDescription(), controller: self)
        loadArticleList(dataModel: dataModel)
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
    func setup(tableView: UITableView) {
        addRefreshControlFor(tableView: tableView)
        setupDelegateAndDataSourceFor(tableView: tableView)
        tableView.removeEmptyCellSeparators()
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }
    
    func setupDelegateAndDataSourceFor(tableView: UITableView) {
        tableViewDataSourceAndDelegate = ArticleListTableViewDataSourceAndDelegate(
            tableView: tableView,
            
            articleList: { [weak self] () -> ([ArticleEntity]) in
                return self?.dataModel.articleList() ?? []
                
            }, articleFavouriteState: { [weak self] (article: ArticleEntity) -> ArticleFavouriteState in
                return (self?.dataModel.favouriteStateFor(article: article) ?? .notFavourite)
                
            }, onFavouriteButtonTapIn: { [weak self] (article: ArticleEntity) in
                self?.dataModel.changeFavouriteStateFor(article: article)
                
            }, onArticleTap: { [weak self] (article: ArticleEntity) in
                self?.showArticleDetailsFor(article: article)
            })
        
        tableView.delegate = tableViewDataSourceAndDelegate
        tableView.dataSource = tableViewDataSourceAndDelegate
    }
    
    func addRefreshControlFor(tableView: UITableView) {
        refreshControl.addTarget(self, action: #selector(onRefreshControlPulldown), for: .valueChanged)
        refreshControl.tintColor = .clear
        tableView.addSubview(refreshControl)
    }
    
    // MARK: - Data
    func loadArticleList(dataModel: SourceArticleListDataModelInterface) {
        dataModel.loadData(onStart: { [weak self] in
            guard let self = self else { return }
            
            self.activityIndicatorView.showActivityIndicatorOn(view: self.view)
        }, onSuccess: { [weak self] in
            guard let self = self else { return }
            self.filterArticleListBy(searchQuery: self.searchBar.text)
            self.activityIndicatorView.hideActivityIndicator()
            
        }, onError: { [weak self] in
            guard let self = self else { return }
            
            print("ERROR! Failed to load: \(String(describing: dataModel))")
            self.activityIndicatorView.hideActivityIndicator()
            self.showGenericNetworkAlert()
        })
    }
    
    // MARK: - UI actions
    @objc func onRefreshControlPulldown(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        loadArticleList(dataModel: dataModel)
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
    
    // MARK: - Filtering
    func filterArticleListBy(searchQuery: String?) {
        dataModel.filterArticleListBy(searchQuery: searchQuery)
    }
    
    // MARK: - Navigation
    func showArticleDetailsFor(article: ArticleEntity) {
        searchBar.resignFirstResponder()
        let viewController = ArticleDetailsViewController(article: article)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
