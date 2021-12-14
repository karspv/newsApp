//
//  SourceListViewControllerTests+LoadData.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-06.
//

import XCTest
@testable import NewsAppKarSpv

extension SourceListViewControllerTests {
    
    // MARK: - Load Data - starts
    func test_viewLoading_startsDataLoading() {
        let controller = SourceListViewController()
        let mockDataModel = MockSourceListDataModel()
        controller.dataModel = mockDataModel
        XCTAssertEqual(mockDataModel.loadSourceList_callCount, 0)
        
        controller.loadViewIfNeeded()
        XCTAssertEqual(mockDataModel.loadSourceList_callCount, 1)
    }
    
    func test_whenDataModelStartsDataLoading_showActivityIndicator() {
        controller.loadSourceList()
        mockDataModel.loadSourceList_onStart_callback?()
        
        XCTAssertEqual(mockActivityIndicator.showActivityIndicator_callCount, 1)
        XCTAssertEqual(mockActivityIndicator.showActivityIndicatorOn_view, controller.view)
    }
    
    // MARK: - Load Data - finishes
    func test_whenDataModelFinishesDataLoading_hidesActivityIndicator() {
        mockDataModel.loadSourceList_onSuccess_callback?()
        
        XCTAssertEqual(mockActivityIndicator.hideActivityIndicator_callCount, 1)
        XCTAssertEqual(mockActivityIndicator.showActivityIndicatorOn_view, nil)
    }
    
    func test_whenDataModelFinishesDataLoading_tableViewShowsDataCorrespondingToDataModel() {
        let sourceList = [SourceEntity(id: "a", title: "a"),
                          SourceEntity(id: "b", title: "b")]
        
        mockDataModel.sourceList = sourceList
        mockDataModel.loadSourceList_onSuccess_callback?()
        
        XCTAssertEqual(controller.tableView.numberOfRows(inSection: 0), 2)
        XCTAssertEqual(doesCellCorrespondTo(source: sourceList[0], at: IndexPath(row: 0, section: 0)), true)
        XCTAssertEqual(doesCellCorrespondTo(source: sourceList[1], at: IndexPath(row: 1, section: 0)), true)
    }
    
    // MARK: - Load Data - fails
    func test_whenDataModelFailsDataLoading_hidesActivityIndicator() {
        mockDataModel.loadSourceList_onError_callback?()
        XCTAssertEqual(mockActivityIndicator.hideActivityIndicator_callCount, 1)
    }
    
    func test_whenDataModelFailsDataLoading_showsGenericNetworkAlertError() {
//        let alert = UIAlertController(title: "test1", message: "test2", preferredStyle: .alert)
//
//        mockAlertsPresenter.genericNetworkAlert = alert
//        mockDataModel.loadSourceList_onError_callback?()
//
//        XCTAssertEqual(mockAlertsPresenter.showGenericNetworkAlert_callCount, 1)
//        XCTAssertEqual(mockAlertsPresenter.genericNetworkAlert?.title, "test1")
//        XCTAssertEqual(mockAlertsPresenter.genericNetworkAlert?.message, "test2")
    }
    
    // MARK: - Helpers
    func doesCellCorrespondTo(source: SourceEntity, at indexPath: IndexPath) -> Bool {
        guard let cell = controller.tableView.cellForRow(at: indexPath) as? SourceListTableViewCell else {
            return false
        }
        return cell.source == source
    }
}
