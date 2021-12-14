//
//  SourceListViewControllerTests.swift
//  NewsAppKarSpvTests
//
//  Created by Karolis on 2021-03-31.
//

import XCTest
@testable import NewsAppKarSpv

class SourceListViewControllerTests: XCTestCase {
    
    // MARK: - Declarations
    var controller: SourceListViewController!
    
    var mockDataModel: MockSourceListDataModel!
    var mockActivityIndicator: MockActivityIndicatorPresenter!
    var mockRouter: MockSourceListRouter!
    
    // MARK: - Methods
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        controller = SourceListViewController()
        
        mockActivityIndicator = MockActivityIndicatorPresenter()
        controller.activityIndicatorPresenter = mockActivityIndicator
        
        mockRouter = MockSourceListRouter()
        controller.router = mockRouter
        
        mockDataModel = MockSourceListDataModel()
        controller.dataModel = mockDataModel
        
        controller.loadViewIfNeeded() // triggers data loading
        mockDataModel.loadSourceList_callCount = 0
    }
    
    override func tearDownWithError() throws {
        controller = nil
        mockActivityIndicator = nil
        mockRouter = nil
        mockDataModel = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Navigation
    func test_whenUserTapsOnCell_openArticleListForCorrespondingSource() {
        let sourceList = [SourceEntity(id: "a", title: "a"),
                          SourceEntity(id: "b", title: "b")]

        mockDataModel.sourceList = sourceList
        controller.tableView.reloadData()

        controller.tableView(controller.tableView.self, didSelectRowAt: IndexPath(row: 1, section: 0))

        XCTAssertEqual(mockRouter.showArticleListForSource_callCount, 1)
        XCTAssertEqual(mockRouter.showArticleListForSource_source, SourceEntity(id: "b", title: "b"))
    }
    
    // MARK: - Actions
    func test_whenUserPullsDownTableView_triggerRefreshData() {
        controller.onRefreshControlPulldown(sender: controller.refreshControl)
        XCTAssertEqual(mockDataModel.loadSourceList_callCount, 1)
    }
    
    // MARK: - Title
    func test_titleIsSourceList() {
        XCTAssertEqual(controller.title, "Source List".localized())
    }
}
