//
//  DiscoveryViewController.swift
//  Khari
//
//  Created by Evan Gruère on 10/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryViewController: UIViewController {
    
    let discoveryView = DiscoveryView()
    
    private(set) var discoveryHeaderViewController = DiscoveryHeaderViewController()
    private(set) var contentViewController = UIViewController()
    
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
    
    func setContentViewController(_ contentViewController: UIViewController) {
        self.addChild(contentViewController)
        self.discoveryView.setContentView(contentViewController.view)
        contentViewController.didMove(toParent: self)
        self.contentViewController = contentViewController
    }
    
    func setDiscoveryHeaderViewController(_ discoveryHeaderViewController: DiscoveryHeaderViewController) {
        self.addChild(discoveryHeaderViewController)
        (self.view as! DiscoveryView).setHeaderView(discoveryHeaderViewController.headerView)
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
    }
    
}
