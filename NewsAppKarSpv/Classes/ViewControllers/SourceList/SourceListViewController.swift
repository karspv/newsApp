//
//  SourceListViewController.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-02.
//

import UIKit

// swiftlint:disable private_outlet
class SourceListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Declarations
    @IBOutlet weak var tableView: UITableView!
    
    var activityIndicatorPresenter: ActivityIndicatorPresenterInterface = ActivityIndicatorPresenter()
    var router: SourceListRouterInterface = SourceListRouter()
    var refreshControl = UIRefreshControl()
    
    var dataModel: SourceListDataModelInterface = SourceListDataModel()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = R.string.localizable.sourceList()
        addRefreshControlFor(tableView: tableView)
        tableView.registerCellNib(withType: SourceListTableViewCell.self)
        tableView.removeEmptyCellSeparators()
        
        loadSourceList()
    }
    
    func addRefreshControlFor(tableView: UITableView) {
        refreshControl.addTarget(self, action: #selector(onRefreshControlPulldown), for: .valueChanged)
        refreshControl.tintColor = .clear
        tableView.addSubview(refreshControl)
    }
    
    // MARK: - Data
    func loadSourceList() {
        dataModel.loadData(onStart: { [weak self] in
            guard let self = self else { return }
            
            self.activityIndicatorPresenter.showActivityIndicatorOn(view: self.view)
        }, onSuccess: { [weak self] in
            guard let self = self else { return }
            
            self.tableView.reloadData()
            self.activityIndicatorPresenter.hideActivityIndicator()
            
        }, onError: { [weak self] in
            guard let self = self else { return }
            
            print("ERROR! Failed to load data")
            self.activityIndicatorPresenter.hideActivityIndicator()
            self.showGenericNetworkAlert()
        })
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.sourceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withType: SourceListTableViewCell.self) else {
            return UITableViewCell()
        }
        
        guard let source: SourceEntity = sourceFor(indexPath: indexPath) else {
            print("ERROR! No source for index: \(indexPath)")
            return UITableViewCell()
        }
        
        cell.populateWith(source: source)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let source: SourceEntity = sourceFor(indexPath: indexPath) else {
            print("ERROR! No source for index: \(indexPath)")
            return
        }
        router.showArticleListFor(source: source, sender: self)
    }
    
    // MARK: - Helpers
    func sourceFor(indexPath: IndexPath) -> SourceEntity? {
        return dataModel.sourceList[safe: indexPath.row]
    }
    
    // MARK: - UI actions
    @objc func onRefreshControlPulldown(sender: AnyObject) {
        refreshControl.endRefreshing()
        loadSourceList()
    }
}
