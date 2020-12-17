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
    
    var mapView: MGLMapView!
    
    private var userLocationDidUpdateCancellable: AnyCancellable!
    private var strangerLocationUpdatedCancellable: AnyCancellable!
    private var strangersDiscoveredCancellable: AnyCancellable!
    
    private lazy var userLocationDidUpdateSubject = PassthroughSubject<CLLocationCoordinate2D, Never>()
    lazy var userLocationDidUpdate = self.userLocationDidUpdateSubject.eraseToAnyPublisher()
    
    var onUserAnnotationSelected: () -> Void = { }
    var onStrangerAnnotationSelected: (Stranger) -> Void = { _ in }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView = MGLMapView(frame: self.view.bounds)
        self.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.mapView.styleURL = MGLStyle.streetsStyleURL
        self.mapView.tintColor = .lightGray
        self.mapView.zoomLevel = 14
        self.mapView.delegate = self
        self.view.addSubview(self.mapView)
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
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        mapView.setUserTrackingMode(.follow, animated: false) { }
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
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        if annotation is StrangerAnnotation {
            let reuseIdentifier = "\(annotation.coordinate.longitude)"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            if annotationView == nil {
                annotationView = StrangerAnnotationView(reuseIdentifier: reuseIdentifier)
            }
            return annotationView
        }
        if annotation is MGLUserLocation {
            return UserAnnotationView()
        }
        return nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
