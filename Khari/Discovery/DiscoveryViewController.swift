//
//  DiscoveryViewController.swift
//  Khari
//
//  Created by Evan Gruère on 10/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryViewController: UIViewController {
    
    var didChangeHeader: () -> Void = { }
    let discoveryView = DiscoveryView()
    
    private(set) var discoveryHeaderViewController = DiscoveryHeaderViewController()
    
    var presentInteractionController: DiscoveryPresentInteractionController?
    var dismissInteractionController: DiscoveryDismissInteractionController?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        self.view = discoveryView
    }
    
    func setDiscoveryHeaderViewController(_ discoveryHeaderViewController: DiscoveryHeaderViewController) {
        discoveryHeaderViewController.willMove(toParent: nil)
        discoveryHeaderViewController.removeFromParent()
        discoveryHeaderViewController.view.removeFromSuperview()
        
        self.addChild(discoveryHeaderViewController)
        
        self.discoveryView.setHeaderView(discoveryHeaderViewController.headerView)
        
        discoveryHeaderViewController.didMove(toParent: self)
        
        discoveryHeaderViewController.view.gestureRecognizers?.forEach {
            self.discoveryHeaderViewController.view.removeGestureRecognizer($0)
        }
        
        self.discoveryHeaderViewController = discoveryHeaderViewController
        
        if let presentingViewController = self.presentingViewController as? HomeViewController {
            self.dismissInteractionController = DiscoveryDismissInteractionController(
            discoveryViewController: self,
            discoveryHeaderViewController: self.discoveryHeaderViewController,
            homeViewController: presentingViewController)
        }
        
        self.didChangeHeader()
        
    }
    
}
