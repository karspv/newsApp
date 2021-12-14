//
//  EventKeys.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-06-08.
//

import Foundation

enum EventKeys: String {
    case failedToChangeArticleFavouriteState
    case articleListBecameVisible
    case articleListSorted
}

// Onboarder comment: Just for reference
// EventKeys+Firebase
// extension EventType {
//    // the only downside is that your events are going to be couple to your analytics clients
//    func shouldBeLoggedByFirebase() -> Bool {
//        switch self {
//        case .failedToChangeArticleFavouriteState,
//             .articleListBecameVisable,
//             .articleListSorted:
//            return true
//        }
//    }
//
//    func isDefaultFirebase() -> Bool {
//        switch self {
//        case .failedToChangeArticleFavouriteState,
//             .articleListBecameVisable,
//             .articleListSorted:
//            return true
//        }
//    }
//
//    func fireBaseEventKey() -> String {
//        switch self {
//        case .failedToChangeArticleFavouriteState,
//             .articleListBecameVisable,
//             .articleListSorted:
//            return true
//        }
//    }
// }
