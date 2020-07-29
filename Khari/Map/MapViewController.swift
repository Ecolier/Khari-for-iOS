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
    
    private var userLocationDidUpdateCancellable: AnyCancellable!
    private var strangerLocationUpdatedCancellable: AnyCancellable!
    private var strangersDiscoveredCancellable: AnyCancellable!
    
    private lazy var userLocationDidUpdateSubject = PassthroughSubject<CLLocationCoordinate2D, Never>()
    lazy var userLocationDidUpdate = self.userLocationDidUpdateSubject.eraseToAnyPublisher()

    var onUserAnnotationSelected: () -> Void = { }
    var onStrangerAnnotationSelected: (Stranger) -> Void = { _ in }
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.mapView.delegate = self
        
        self.strangerLocationUpdatedCancellable = SocketManager.shared().onStrangerLocationUpdated.sink { stranger in
            self.updateStrangerAnnotationLocation(with: stranger)
        }
        
        self.strangersDiscoveredCancellable = SocketManager.shared().onStrangerDiscovered.sink { stranger in
            self.addStranger(stranger)
        }
        
        self.userLocationDidUpdateCancellable = self.userLocationDidUpdate.sink { coordinates in
            guard let token = AuthenticationRepository.fetchToken() else { return }
            SocketManager.shared().updateUserLocation(token: token,
                                                      longitude: coordinates.longitude,
                                                      latitude: coordinates.latitude)
        }
    }
    
    func strangerExists(_ username: String) -> Bool {
        if let annotations = self.mapView.annotations as? [StrangerAnnotation] {
            for annotation in annotations {
                if annotation.stranger.username == username {
                    return true
                }
            }
        }
        return false
    }
    
    func updateStrangerAnnotationLocation(with stranger: Stranger) {
        if let annotations = self.mapView.annotations as? [StrangerAnnotation] {
            annotations.forEach { annotation in
                if annotation.stranger.username == stranger.username {
                    UIView.animate(withDuration: 2) {
                        annotation.coordinate = CLLocationCoordinate2D(latitude: stranger.latitude,
                                                                       longitude: stranger.longitude)
                    }
                }
            }
        }
    }
    
    func addStranger(_ stranger: Stranger) {
        if self.strangerExists(stranger.username) {
            return
        }
        let annotation = StrangerAnnotation(stranger: stranger)
        annotation.coordinate = CLLocationCoordinate2D(latitude: stranger.latitude, longitude: stranger.longitude)
        self.mapView.addAnnotation(annotation)
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
