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

class HomeViewController: UIViewController {
    
    private var userLocationDidUpdateCancellable: AnyCancellable!
    private var loginCancellable: AnyCancellable!
    
    let homeView: HomeView
    let user: User
    let socket: SocketIOClient
    
    var discoveryViewController = DiscoveryViewController(discoveryView: UserView()) {
        didSet {
            oldValue.removeFromParent()
            self.addChild(self.discoveryViewController)
            self.discoveryViewController.view.translatesAutoresizingMaskIntoConstraints = false
            self.homeView.discoveryView = self.discoveryViewController.discoveryView
            self.discoveryViewController.didMove(toParent: self)
            oldValue.didMove(toParent: nil)
        }
    }
    
    let mapViewController = MapViewController()
    var discoveredStrangers = [Stranger]()
    
    init(user: User, socket: SocketIOClient) {
        
        self.user = user
        self.socket = socket
    
        self.homeView = HomeView(mapView: self.mapViewController.mapView)
        
        super.init(nibName: nil, bundle: nil)
        
        self.socket.on("strangers discovered") { data, ack in
            data.forEach {
                let stranger = Stranger(from: $0 as! [String: Any])
                self.mapViewController.addStranger(stranger)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.discoveryViewController = UserViewController(self.user)
        
        self.mapViewController.onUserAnnotationSelected = {
            self.discoveryViewController = UserViewController(self.user)
        }
        
        self.mapViewController.onStrangerAnnotationSelected = { stranger in
            self.discoveryViewController = StrangerViewController(user: self.user, stranger: stranger)
        }
        
        self.userLocationDidUpdateCancellable = self.mapViewController.userLocationDidUpdate.sink { coordinates in
            
            self.socket.emit("update location",
                             ["username": self.user.username, "password": self.user.password,
                              "latitude": coordinates.latitude, "longitude": coordinates.longitude])
            
            
        }
    }
    
}
