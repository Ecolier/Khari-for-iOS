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
    
    let mapViewController = MapViewController()
    private(set) var discoveryHeaderViewController = DiscoveryHeaderViewController()
    var discoveryViewController = DiscoveryViewController()
    
    let homeView = HomeView()
    
    init(with user: User) {
        self.user = user
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
        
        self.setDiscoveryHeaderViewController(DiscoveryHeaderViewController())
        self.discoveryHeaderViewController.username = self.user.username
        
        self.mapViewController.onUserAnnotationSelected = {
            self.discoveryHeaderViewController.username = self.user.username
        }
        
        self.mapViewController.onStrangerAnnotationSelected = { stranger in
            self.discoveryHeaderViewController.username = stranger.username
            self.setDiscoveryViewController(StrangerDiscoveryViewController(with: stranger))
        }
    }
    
    func setDiscoveryViewController(_ discoveryViewController: DiscoveryViewController) {
        
        discoveryViewController.presentInteractionController = DiscoveryPresentInteractionController(
            discoveryViewController: discoveryViewController,
            discoveryHeaderViewController: self.discoveryHeaderViewController,
            homeViewController: self)
        
        self.discoveryViewController = discoveryViewController
    }
    
    func setDiscoveryHeaderViewController(_ discoveryHeaderViewController: DiscoveryHeaderViewController) {
        
        discoveryHeaderViewController.willMove(toParent: self)
        discoveryHeaderViewController.removeFromParent()
        discoveryHeaderViewController.view.removeFromSuperview()
        
        self.addChild(discoveryHeaderViewController)
        
        self.homeView.setDiscoveryHeaderView(discoveryHeaderViewController.headerView)
        
        discoveryHeaderViewController.didMove(toParent: self)
        
        discoveryHeaderViewController.view.gestureRecognizers?.forEach {
            discoveryHeaderViewController.view.removeGestureRecognizer($0)
        }
        
        self.discoveryHeaderViewController = discoveryHeaderViewController
    }
}
