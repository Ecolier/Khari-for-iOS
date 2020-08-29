//
//  Main.swift
//  Khari
//
//  Created by Evan Gruère on 17/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit
import Combine
import CoreLocation

class HomeViewController: UIViewController {
    
    let user: User
    let homeView = HomeView()
    
    let mapViewController = MapViewController()
    
    var discoveryViewController: DiscoveryViewController! {
        didSet {
            oldValue.removeFromParent()
            oldValue.didMove(toParent: nil)
            self.addChild(discoveryViewController)
            self.homeView.discoveryView = discoveryViewController.view as? DiscoveryView
            discoveryViewController.didMove(toParent: self)
        }
    }
    
    init(with user: User) {
        self.user = user
        self.discoveryViewController = UserDiscoveryViewController(with: user)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChild(self.mapViewController)
        self.homeView.mapView = self.mapViewController.view as? MapView
        self.mapViewController.didMove(toParent: self)
        
        self.discoveryViewController = UserDiscoveryViewController(with: self.user)
        
        self.mapViewController.onUserAnnotationSelected = {
            guard let user = AuthenticationRepository.fetchUser() else { return }
            self.discoveryViewController = UserDiscoveryViewController(with: user)
        }
        
        self.mapViewController.onStrangerAnnotationSelected = { stranger in
            self.discoveryViewController = StrangerDiscoveryViewController(with: stranger)
        }
    }
}
