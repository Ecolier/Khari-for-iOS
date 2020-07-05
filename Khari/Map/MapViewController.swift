//
//  MapViewController.swift
//  Khari
//
//  Created by Evan Gruère on 08/12/2019.
//  Copyright © 2019 Evan Gruère. All rights reserved.
//

import UIKit
import CoreLocation
import Mapbox
import Combine

class MapViewController: UIViewController, MGLMapViewDelegate {
    
    let mapView = MapView()
    var discoveredStrangers = [Stranger]()
    
    private lazy var userLocationDidUpdateSubject = PassthroughSubject<CLLocationCoordinate2D, Never>()
    lazy var userLocationDidUpdate = self.userLocationDidUpdateSubject.eraseToAnyPublisher()
    
    private var generateStrangersCancellable: AnyCancellable!
    
    var onUserAnnotationSelected: () -> Void = { }
    var onStrangerAnnotationSelected: (Stranger) -> Void = { _ in }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.mapView.delegate = self
        
        self.generateStrangersCancellable = self.userLocationDidUpdate.sink { coordinates in
            
            self.user.latitude = coordinates.latitude
            self.user.longitude = coordinates.longitude
            
            if self.discoveredStrangers.count < 5 {
                
                for _ in 0 ..< 5 {
                    let stranger = Stranger.random(around: CLLocationCoordinate2D(latitude: self.user.latitude,
                                                                                  longitude: self.user.longitude), for: 0.5)
                    self.discoveredStrangers.append(stranger)
                    let annotation = StrangerAnnotation(stranger: stranger)
                    annotation.coordinate = CLLocationCoordinate2D(latitude: stranger.latitude, longitude: stranger.longitude)
                    annotation.title = stranger.identifier
                    self.mapView.addAnnotation(annotation)
                }
                
            }
            
        }
        
    }
    
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        if let coordinate = userLocation?.coordinate {
            if (!CLLocationCoordinate2DIsValid(coordinate)) {
                return
            }
            self.userLocationDidUpdateSubject.send(coordinate)
        }
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        if annotation is MGLUserLocation {
            self.onUserAnnotationSelected()
        } else if annotation is StrangerAnnotation {
            
            if let stranger = (annotation as? StrangerAnnotation)?.stranger {
                self.onStrangerAnnotationSelected(stranger)
            }
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.mapView
    }
    
}
