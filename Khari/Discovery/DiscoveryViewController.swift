//
//  DiscoveryViewController.swift
//  Khari
//
//  Created by Evan Gruère on 10/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryViewController: UIViewController {
    
    let discoveryHeaderViewController = DiscoveryHeaderViewController()
    private(set) var userViewController = UIViewController()
    
    let discoveryView = DiscoveryView()
    
    override func loadView() {
        self.view = self.discoveryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChild(self.discoveryHeaderViewController)
        self.discoveryView.setDiscoveryHeaderView(self.discoveryHeaderViewController.view as! DiscoveryHeaderView)
        self.discoveryHeaderViewController.didMove(toParent: self)
        
        self.addChild(self.userViewController)
        self.discoveryView.setUserView(self.userViewController.view)
        self.userViewController.didMove(toParent: self)
    }
    
    func setUserViewController(_ viewController: UIViewController) {
        self.userViewController.removeFromParent()
        self.userViewController.didMove(toParent: nil)
        self.addChild(viewController)
        self.discoveryView.setUserView(viewController.view)
        viewController.didMove(toParent: self)
        self.userViewController = viewController
    }
}
