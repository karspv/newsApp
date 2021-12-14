//
//  SourceListTableViewCellTests.swift
//  NewsAppKarSpvTests
//
//  Created by Karolis on 2021-03-30.
//

import XCTest
@testable import NewsAppKarSpv

class SourceListTableViewCellTests: XCTestCase {
    
    // MARK: - Declarations
    var cell: SourceListTableViewCell!
    
    // MARK: - Methods
    override func setUpWithError() throws {
        try super.setUpWithError()
        cell = UIView.loadXib(ofClass: SourceListTableViewCell.self) as? SourceListTableViewCell
    }
    
    override func tearDownWithError() throws {
        cell = nil
        try super.tearDownWithError()
    }
    
    func test_populateWithSource_updatesSource() {
        let source = SourceEntity(id: "a", title: "test", description: "aaa")
        cell.populateWith(source: source)
        XCTAssertEqual(cell.source, source)
    }
    
    func test_populateWithSource_titleLabelShowsSourceTitle() {
        let source = SourceEntity(id: "a", title: "test", description: "aaa")
        cell.populateWith(source: source)
        XCTAssertEqual(cell.titleLabel.text, "test")
    }
    
    func test_populateWithSource_descriptionLabelShowsSourceDescription() {
        let source = SourceEntity(id: "a", title: "aaa", description: "testtest")
        cell.populateWith(source: source)
        XCTAssertEqual(cell.descriptionLabel.text, "testtest")
    }
}
