//
//  MapView+Tools.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-27.
//

import Foundation
import MapKit
import CoreLocation

private let kTopEdgeInsets: CGFloat = 100
private let kLeftEdgeInsets: CGFloat = 100
private let kBottomEdgeInsets: CGFloat = 100
private let kRightEdgeInsets: CGFloat = 100

extension MKMapView {
    
    func fitAllAnnotations() {
        var zoomRect = MKMapRect.null
        
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01)
            zoomRect = zoomRect.union(pointRect)
        }
        
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: kTopEdgeInsets,
                                                              left: kLeftEdgeInsets,
                                                              bottom: kBottomEdgeInsets,
                                                              right: kRightEdgeInsets), animated: true)
    }
}
