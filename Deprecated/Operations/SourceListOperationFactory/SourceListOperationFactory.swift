//
//  SourceListOperationFactory.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-07.
//

import Foundation

protocol SourceListOperationFactoryInterface {
    func operation() -> GetSourceListOperationInterface
}

class SourceListOperationFactory: SourceListOperationFactoryInterface {
    
    let getSourceListOperation = GetSourceListOperation()
    
    func operation() -> GetSourceListOperationInterface {
        return getSourceListOperation
    }
}
