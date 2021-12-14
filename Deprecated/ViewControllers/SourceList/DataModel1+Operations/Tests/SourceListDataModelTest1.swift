//
//  SourceListDataModelTest1.swift
//  NewsAppKarSpvTests
//
//  Created by Karolis on 2021-04-07.
//

import XCTest
@testable import NewsAppKarSpv

class SourceListDataModelTest1: XCTestCase {
    
    // MARK: - Declarations
    var dataModel: SourceListDataModel1!
    var mockOperationFactory: MockSourceListOperationFactory!
    
    // MARK: - Methods
    override func setUpWithError() throws {
        try super.setUpWithError()
        dataModel = SourceListDataModel1()
        dataModel.operationQueue.isSuspended = true
        mockOperationFactory = MockSourceListOperationFactory()
        dataModel.operationFactory = mockOperationFactory
    }
    
    override func tearDownWithError() throws {
        dataModel = nil
        mockOperationFactory = nil
        try super.tearDownWithError()
    }
    
    // MARK: - loadData - start
    func test_loadData_triggersOperationDataLoadingFromAPI() {
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        
        XCTAssertEqual(dataModel.operationQueue.operationCount, 1)
        XCTAssertEqual(mockOperationFactory.operation_callCount, 1)
    }
    
    func test_loadData_whenApiStartsDataLoading_triggersOnStartCallback() {
        var callbackCount = 0
        
        dataModel.loadData(onStart: { callbackCount += 1 }, onSuccess: {}, onError: {})
        
        XCTAssertEqual(callbackCount, 1)
    }
    
    // MARK: - loadData - finish
    func test_loadData_whenApiFinishesDataLoading_triggersOnSuccessCallback() {
        var callbackCount = 0
        mockOperationFactory.mockGetSourceListOperation.output().isSuccessful = true
        
        dataModel.loadData(onStart: {}, onSuccess: { callbackCount += 1 }, onError: {})
        mockOperationFactory.mockGetSourceListOperation.completionBlock?()
        
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_loadData_whenApiFinishesDataLoading_setsSourceListFromApi() {
        let sourceList = [SourceEntity(id: "id", title: "title", description: "description")]
        mockOperationFactory.mockGetSourceListOperation.output().sourceList = sourceList
        mockOperationFactory.mockGetSourceListOperation.output().isSuccessful = true
        
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        mockOperationFactory.mockGetSourceListOperation.completionBlock?()
        
        XCTAssertEqual(dataModel.sourceList, sourceList)
    }
    
    // MARK: - loadData - fail
    func test_loadData_whenApiFailsDataLoading_triggersOnErrorCallback() {
        var callbackCount = 0
        mockOperationFactory.mockGetSourceListOperation.output().isSuccessful = false
        
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: { callbackCount += 1 })
        mockOperationFactory.mockGetSourceListOperation.completionBlock?()
        
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_loadData_whenApiFailsDataLoading_sourceListIsLeftUnchanged() {
        dataModel.sourceList = [SourceEntity(id: "id", title: "title", description: "description")]
        mockOperationFactory.mockGetSourceListOperation.output().isSuccessful = false
        mockOperationFactory.mockGetSourceListOperation.output().sourceList = [SourceEntity(id: "id2", title: "title", description: "description")]
        
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        mockOperationFactory.mockGetSourceListOperation.completionBlock?()
        
        XCTAssertEqual(dataModel.sourceList, [SourceEntity(id: "id", title: "title", description: "description")])
    }
    
    // MARK: - Single data loading
    func test_loadData_doesNotStartDataLoadingIfOneIsInProgress() {
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        
        XCTAssertEqual(mockOperationFactory.operation_callCount, 1)
    }
    
    func test_loadData_startsAPIRequest_ifPreviousAPIRequestIsFinished() {
        
        mockOperationFactory.mockGetSourceListOperation.output().isSuccessful = true
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        mockOperationFactory.mockGetSourceListOperation.completionBlock?()
        mockOperationFactory.operation_callCount = 0
        
        dataModel.loadData(onStart: {}, onSuccess: {}, onError: {})
        
        XCTAssertEqual(mockOperationFactory.operation_callCount, 1)
    }
}
