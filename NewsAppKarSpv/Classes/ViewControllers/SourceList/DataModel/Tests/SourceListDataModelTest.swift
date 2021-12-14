//
//  SourceListDataModelTest.swift
//  NewsAppKarSpvTests
//
//  Created by Karolis on 2021-03-30.
//

import XCTest
@testable import NewsAppKarSpv

class SourceListDataModelTest: XCTestCase {
    
    // MARK: - Declarations
    var dataModel: SourceListDataModel!
    var mockSourceApiClient: MockSourceApiClient!
    
    // MARK: - Methods
    override func setUpWithError() throws {
        try super.setUpWithError()

        mockSourceApiClient = MockSourceApiClient()
        
        dataModel = SourceListDataModel()
        dataModel.sourceApiClient = mockSourceApiClient
    }
    
    override func tearDownWithError() throws {
        mockSourceApiClient = nil
        dataModel = nil
        try super.tearDownWithError()
    }
    
    // MARK: - loadData - start
    func test_loadData_triggersDataLoadingFromAPI() {
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        
        XCTAssertEqual(mockSourceApiClient.loadSourceList_callCount, 1)
    }
    
    func test_loadData_whenApiStartsDataLoading_triggersOnStartCallback() {
        var callbackCount = 0
        dataModel.loadData(onStart: { callbackCount += 1 }, onSuccess: {}, onError: {})
        XCTAssertEqual(callbackCount, 1)
    }
    
    // MARK: - loadData - finish
    func test_loadData_whenApiFinishesDataLoading_triggersOnSuccessCallback() {
        var callbackCount = 0
        
        dataModel.loadData(onStart: {}, onSuccess: { callbackCount += 1 }, onError: {})
        mockSourceApiClient.loadSourceList_onSuccess_callback?([])
        
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_loadData_whenApiFinishesDataLoading_setsSourceListFromApi() {
        let sourceList: [SourceEntity] = [SourceEntity(id: "id", title: "title", description: "description")]
        
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        mockSourceApiClient.loadSourceList_onSuccess_callback?(sourceList)
        
        XCTAssertEqual(dataModel.sourceList, sourceList)
    }
    
    // MARK: - loadData - fail
    func test_loadData_whenApiFailsDataLoading_triggersOnErrorCallback() {
        var callbackCount = 0
        
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: { callbackCount += 1 })
        mockSourceApiClient.loadSourceList_onError_callback?()
        
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_loadData_whenApiFailsDataLoading_sourceListIsLeftUnchanged() {
        dataModel.sourceList = [SourceEntity(id: "id", title: "title", description: "description")]
        
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        mockSourceApiClient.loadSourceList_onError_callback?()
        
        XCTAssertEqual(dataModel.sourceList, [SourceEntity(id: "id", title: "title", description: "description")])
    }
    
    // MARK: - Single data loading
    func test_loadData_doesNotStartDataLoadingIfOneIsInProgress() {
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        
        XCTAssertEqual(mockSourceApiClient.loadSourceList_callCount, 1)
    }
    
    func test_loadData_startsAPIRequest_ifPreviousAPIRequestIsFinished() {
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        mockSourceApiClient.loadSourceList_onSuccess_callback?([])
        mockSourceApiClient.loadSourceList_callCount = 0
        
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        
        XCTAssertEqual(mockSourceApiClient.loadSourceList_callCount, 1)
    }
}
