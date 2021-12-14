//
//  BowlingCalculatorTests.swift
//  NewsAppKarSpvTests
//
//  Created by Admin on 2021-03-30.
//

import XCTest
@testable import BowlingScoreCalculator

class BowlingCalculatorTests: XCTestCase {
    
    var calculator: BowlingCalculator!
    
    override func setUpWithError() throws {
        super.setUpWithError()
        calculator = BowlingCalculator()
    }
    
    override func tearDownWithError() throws {
        calculator = nil
        super.tearDownWithError()
    }
    
    func test_whenUserHitsNoPins_rezultIs_0() {
        
        let score = calculator.scoreFor(throwList: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(score, 0)
    }
    
    func test_scoreIsSumOfAllThrows_whenNoStrikesOrSparesAreHit() {
        
        let score = calculator.scoreFor(throwList: [1, 2, 3, 0, 0, 0, 0, 0, 0, 0,
                                                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(score, 6)
    }
    
    func test_whenStrikeIsScored_increaseScoreWithTheNextTwoThrows() {
        
        let score = calculator.scoreFor(throwList: [10, 1, 1, 0, 0, 0, 0, 0, 0,
                                                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(score, 14)
    }
    
    func test_whenSpareIsScored_increaseScoreWithTheNextSingleThrow() {
        
        var score = calculator.scoreFor(throwList: [0, 10, 3, 2, 0, 0, 0, 0, 0, 0,
                                                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(score, 18)
        
        score = calculator.scoreFor(throwList: [0, 10, 0, 1, 0, 0, 0, 0, 0, 0,
                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(score, 11)
        
        score = calculator.scoreFor(throwList: [6, 4, 1, 1, 0, 0, 0, 0, 0, 0,
                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(score, 13)
    }
    
    func test_extraBallsFor10thFrame_countAsBonusPointsButNotAsPointsThemselves() {
        
        var score = calculator.scoreFor(throwList: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                    0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10])
        XCTAssertEqual(score, 30)
        
        score = calculator.scoreFor(throwList: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                0, 0, 0, 0, 0, 0, 0, 0, 1, 9, 5])
        XCTAssertEqual(score, 15)
    }
    
    func test_allStrikesScores_300() {
        
        let score = calculator.scoreFor(throwList: [10, 10, 10, 10, 10,
                                                    10, 10, 10, 10, 10, 10, 10])
        XCTAssertEqual(score, 300)
    }
    
    // MARK: - Real games samples
    func test_realGameSamples() {
        
        var score = calculator.scoreFor(throwList: [9, 1, 5, 5, 7, 0, 8, 1, 4, 6, 9, 1, 10, 10, 10, 10, 8, 2])
        XCTAssertEqual(score, 195)
        
        score = calculator.scoreFor(throwList: [5, 5, 5, 0, 10, 3, 2, 7, 1, 10, 7, 1, 1, 8, 1, 8, 1, 6])
        XCTAssertEqual(score, 99)
    }
}
