//
//  AnnotationPin.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-28.
//

import Foundation
import MapKit

class AnnotationPin: NSObject, MKAnnotation {

    // MARK: - Declarations
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    // MARK: - Methods
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
