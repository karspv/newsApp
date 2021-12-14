//
//  MapViewController.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-27.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: - Constants
    let kReusableAnnotationIdentifier: String = "userPin"
    
    // MARK: - Declarations
    @IBOutlet private weak var mapView: MKMapView!
    var locationPresenter: UserLocationPresenter?
    var dataModel: MapViewDataModelInterface = MapViewDataModel()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.localizable.map()
        
        mapView.delegate = self
        
        locationPresenter = UserLocationPresenter(didUpdateLocation: { [weak self] (location: CLLocation) in
            guard let self = self else { return }
            self.dataModel.loadAnnotationPinListFor(location: location, didFinishLoading: {
                self.addAnnotationPinsToMapView(pinList: self.dataModel.pinList)
            })
        }, didAuthorizeLocation: { [weak self] in
            self?.mapView.showsUserLocation = true
        })
        
        locationPresenter?.startLocatingIfAuthorized()
    }
    
    func addAnnotationPinsToMapView(pinList: [AnnotationPin]) {
        mapView.addAnnotations(pinList)
        mapView.fitAllAnnotations()
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? AnnotationPin else {
            return nil
        }
        
        var annotationView: MKAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: kReusableAnnotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: kReusableAnnotationIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = R.image.favouritedStar()
        return annotationView
    }
}
