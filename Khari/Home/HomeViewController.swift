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
    
    let homeView = HomeView()
    
    var discoveryViewController = DiscoveryViewController()
    let mapViewController = MapViewController()
    
    override func loadView() {
        self.view = self.homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChild(self.mapViewController)
        self.homeView.setMapView(self.mapViewController.view)
        self.mapViewController.didMove(toParent: self)
        
        self.addChild(self.discoveryViewController)
        self.homeView.setDiscoveryView(self.discoveryViewController.view as! DiscoveryView)
        self.discoveryViewController.didMove(toParent: self)
        
        guard let token = AuthenticationRepository.fetchToken(),
            let user = AuthenticationRepository.fetchUser() else { return }
        
        self.discoveryViewController.discoveryHeaderViewController.headerView.usernameLabel.text = user.username
        self.discoveryViewController.setUserViewController(UserViewController())
        
        self.mapViewController.onUserAnnotationSelected = {
            guard let token = AuthenticationRepository.fetchToken(),
                let user = AuthenticationRepository.fetchUser() else { return }
            self.discoveryViewController.discoveryHeaderViewController.headerView.usernameLabel.text = user.username
            self.discoveryViewController.setUserViewController(UserViewController())
        }
        
        self.mapViewController.onStrangerAnnotationSelected = { stranger in
            guard let token = AuthenticationRepository.fetchToken(),
                let user = AuthenticationRepository.fetchUser() else { return }
            self.discoveryViewController.discoveryHeaderViewController.headerView.usernameLabel.text = stranger.username
            self.discoveryViewController.setUserViewController(
                StrangerViewController(token: token,
                                       user: user,
                                       stranger: stranger)
            )
        }
        
        
    }
}
