//
//  SourceEntity.swift
//  NewsAppKarSpv
//
//  Created by Admin on 2021-03-02.
//

import Foundation

class SourceEntity: Equatable {
    
    // MARK: - Declarations
    var id: String
    var title: String
    var description: String = ""
    
    // MARK: - Methods
    init(id: String, title: String, description: String = "") {
        self.id = id
        self.title = title
        self.description = description
    }
    
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String else {
            print("ERROR! No id in dict: \(dictionary)")
            return nil
        }
        
        guard let title = dictionary["name"] as? String else {
            print("ERROR! No title in dict: \(dictionary)")
            return nil
        }
        
        self.title = title
        self.id = id
        description = dictionary["description"] as? String ?? ""
    }
    
    static func sourceListFrom(dictList: [[String: Any]]) -> [SourceEntity] {
        var sourceList: [SourceEntity] = []
        
        for sourceDict in dictList {
            guard let source = SourceEntity(dictionary: sourceDict) else {
                print("ERROR! Could not create Source from: \(sourceDict)")
                continue
            }
            sourceList.append(source)
        }
        return sourceList
    }
    
    // MARK: - Equatable protocol
    static func == (lhs: SourceEntity, rhs: SourceEntity) -> Bool {
        return lhs.id == lhs.id
    }
}

// MARK: - Default
extension SourceEntity {
    static var `default` = SourceEntity(id: "TestId", title: "TestTitle", description: "TestDescription")
}
