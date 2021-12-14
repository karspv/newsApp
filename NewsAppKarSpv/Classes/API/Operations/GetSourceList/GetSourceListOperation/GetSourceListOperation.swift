//
//  GetSourceListOperation.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-25.
//

import Foundation

protocol GetSourceListOperationInterface: Operation {
    func output() -> GetSourceListOutput
}

// swiftlint:disable force_cast
class GetSourceListOperation: TSMBaseServerOperation, GetSourceListOperationInterface {
    
    // MARK: - Methods for overriding - TSMBaseOperation
    override func createOutput() -> TSMBaseOperationOutput {
        return GetSourceListOutput()
    }
    
    // MARK: - Methods for overriding - TSMBaseServerOperation
    override func urlMethodName() -> String {
        return "sources"
    }
    
    override func httpMethod() -> String {
        return "GET"
    }
    
    override func additionalHeaderParametersDictionary() -> [String: String]? {
        return ["Authorization": Constants.APIOperation.key]
    }
    
    override func parseResponseDict(_ responseDict: [String: Any]) {
        guard let dictList = responseDict["sources"] as? [[String: Any]] else {
            print("ERROR! Could not create dictList from: \(responseDict)")
            return
        }
        let sourceList: [SourceEntity] = SourceEntity.sourceListFrom(dictList: dictList)
        
        output().sourceList = sourceList
        output.isSuccessful = true
    }
    
    // MARK: - Public - Helpers
    func output() -> GetSourceListOutput {
        return output as! GetSourceListOutput
    }
}
