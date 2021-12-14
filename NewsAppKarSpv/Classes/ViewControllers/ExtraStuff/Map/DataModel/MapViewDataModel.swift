//
//  MapViewDataModel.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-31.
//

import Foundation
import MapKit

protocol MapViewDataModelInterface {
    var pinList: [AnnotationPin] { get }
    
    func loadAnnotationPinListFor(location: CLLocation, didFinishLoading: @escaping() -> Void)
}

class MapViewDataModel: MapViewDataModelInterface {
    
    // MARK: - Declarations
    var pinList: [AnnotationPin] = []
    
    // MARK: - Methods
    func loadAnnotationPinListFor(location: CLLocation, didFinishLoading: @escaping() -> Void) {
        pinList = [AnnotationPin(title: R.string.localizable.randomUser(),
                                 subtitle: R.string.localizable.extraNiceUser(),
                                 coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                                    longitude: location.coordinate.longitude)),
                   AnnotationPin(title: R.string.localizable.anotherRandomUser(),
                                 subtitle: R.string.localizable.simplePimpleUser(),
                                 coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude + 1,
                                                                    longitude: location.coordinate.longitude + 1))]
        didFinishLoading()
    }
}
