//
//  Main.swift
//  Khari
//
//  Created by Evan Gruère on 17/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit
import Combine
import SocketIO
import CoreLocation

class HomeViewController: CoverableViewController {
    
    private var userLocationDidUpdateCancellable: AnyCancellable!
    private var loginCancellable: AnyCancellable!
    
    let mapViewController = MapViewController()
    let discoveryViewController = DiscoveryViewController()
    
    let user: User
    let socket: SocketIOClient
    
    var discoveredStrangers = [Stranger]()
    
    init(user: User, socket: SocketIOClient) {
        
        self.user = user
        self.socket = socket
        
        super.init(nibName: nil, bundle: nil)
        
        self.fullscreenViewController = self.mapViewController
        self.collapsableViewController = self.discoveryViewController
        
        self.socket.on("strangers discovered") { dataArray, ack in
            
            if self.discoveredStrangers.count < dataArray.count {
                
                for data in dataArray {
                    if let dict = data as? [String: Any],
                        let username = dict["username"] as? String,
                        let location = dict["location"] as? [String: Any],
                        let coordinates = location["coordinates"] as? [Double] {
                        
                        if username != self.user.username {
                            
                            let stranger = Stranger(identifier: username, longitude: coordinates[0], latitude: coordinates[1])

                            self.discoveredStrangers.append(stranger)
                            
                            let annotation = StrangerAnnotation(stranger: stranger)
                            annotation.coordinate = CLLocationCoordinate2D(latitude: stranger.latitude, longitude: stranger.longitude)
                            annotation.title = stranger.identifier
                            self.mapViewController.mapView.addAnnotation(annotation)
                            
                        }
                        
                    }
                }
                
            }
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userController = UserController()
        userController.managedUser = self.user
        self.discoveryViewController.managedViewController = userController
        
        self.mapViewController.onUserAnnotationSelected = {
            let userController = UserController()
            userController.managedUser = self.user
            self.discoveryViewController.managedViewController = userController
        }
        
        self.mapViewController.onStrangerAnnotationSelected = { stranger in
            let strangerController = StrangerController()
            strangerController.managedStranger = stranger
            self.discoveryViewController.managedViewController = strangerController
        }
        
        self.userLocationDidUpdateCancellable = self.mapViewController.userLocationDidUpdate.sink { coordinates in
            
            self.socket.emit("update location",
                             ["username": self.user.username, "password": self.user.password, "latitude": coordinates.latitude, "longitude": coordinates.longitude])
            
            self.socket.emit("discover strangers",
            ["latitude": coordinates.latitude, "longitude": coordinates.longitude])
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let userView = self.discoveryViewController.managedViewController.view as? UserView {
            let userHeader = userView.userHeader
            self.discoveryViewController.discoveryView.collapsedY = self.view.bounds.height - userHeader.frame.height
            self.discoveryViewController.discoveryView.fullY = self.view.safeAreaInsets.top
            self.discoveryViewController.discoveryView.breakY = self.view.bounds.height / 2
            self.discoveryViewController.discoveryView.frame = CGRect(
                x: 0, y: self.view.bounds.height - userHeader.frame.height,
                width: self.view.bounds.width, height: self.view.bounds.height - self.view.safeAreaInsets.top)
        }
        
    }
    
}
