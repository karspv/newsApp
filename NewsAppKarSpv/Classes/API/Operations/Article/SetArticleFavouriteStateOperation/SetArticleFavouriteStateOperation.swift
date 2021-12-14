//
//  SetArticleFavouriteStateOperation.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-30.
//

import Foundation

protocol SetArticleFavouriteStateInterface: Operation {
    func output() -> SetArticleFavouriteStateOutput
    func input() -> SetArticleFavouriteStateInput
}

// swiftlint:disable force_cast
class SetArticleFavouriteStateOperation: TSMBaseServerOperation {
    
    // MARK: - Constants
    var kOperationDurationRange: Range = 1.0..<3.5
    var kPercentageOfOperationFailure = 20
    
    // MARK: - Methods for overriding - TSMBaseOperation
    override func createOutput() -> TSMBaseOperationOutput {
        return SetArticleFavouriteStateOutput()
    }
    
    override func startOperation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: kOperationDurationRange), execute: {
            
            if self.isOperationSuccessful() {
                self.output().newFavouriteState = self.input().shouldBeFavourite
                self.output.isSuccessful = true
            } else {
                self.output.isSuccessful = false
            }
            self.finishOperation()
            
        })
    }
    
    func isOperationSuccessful() -> Bool {
        return Int.random(in: 0...100) > self.kPercentageOfOperationFailure
    }
    
    // MARK: - Public
    func output() -> SetArticleFavouriteStateOutput {
        return output as! SetArticleFavouriteStateOutput
    }
    
    func input() -> SetArticleFavouriteStateInput {
        return input as! SetArticleFavouriteStateInput
    }
}
