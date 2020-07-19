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
    var user: User!
    var token: String!
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
    
    init(socket: SocketIOClient) {
        
        self.socket = socket
    
        self.homeView = HomeView(mapView: self.mapViewController.mapView)
        
        super.init(nibName: nil, bundle: nil)
        
        self.socket.on("stranger location updated") { data, ack in
            if let stranger = data[0] as? [String: Any] {
                do {
                    let data = try JSONSerialization.data(withJSONObject: stranger)
                    let stranger = try JSONDecoder().decode(Stranger.self, from: data)
                    self.mapViewController.updateStrangerAnnotationLocation(with: stranger)
                } catch { print(error) }
            }
        }
        
        self.socket.on("strangers discovered") { data, ack in
            if self.discoveredStrangers.count < data.count {
                data.forEach {
                    let data = try! JSONSerialization.data(withJSONObject: $0 as! [String: Any])
                    let stranger = try! JSONDecoder().decode(Stranger.self, from: data)
                    self.discoveredStrangers.append(stranger)
                    self.mapViewController.addStranger(stranger)
                }
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
            self.discoveryViewController = StrangerViewController(token: self.token, user: self.user, stranger: stranger)
        }
        
        self.userLocationDidUpdateCancellable = self.mapViewController.userLocationDidUpdate.sink { coordinates in
            
            self.socket.emit(
                "update location",
                ["token": self.token, "latitude": coordinates.latitude, "longitude": coordinates.longitude]
            )
            
            
        }
    }
    
}
