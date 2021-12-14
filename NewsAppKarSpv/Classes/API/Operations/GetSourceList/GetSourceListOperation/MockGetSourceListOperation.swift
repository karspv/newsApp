//
//  MockGetSourceListOperation.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-07.
//

import Foundation

class MockGetSourceListOperation: TSMBaseOperation, GetSourceListOperationInterface {
    
    var sourceListOutput: GetSourceListOutput
    
    init(output: GetSourceListOutput) {
        self.sourceListOutput = output
    }
    
    func output() -> GetSourceListOutput {
        return sourceListOutput
    }
}
