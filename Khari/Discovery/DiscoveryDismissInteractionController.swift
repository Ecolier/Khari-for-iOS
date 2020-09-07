//
//  DiscoveryInteractionController.swift
//  Khari
//
//  Created by Evan Gruère on 02/09/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryDismissInteractionController: UIPercentDrivenInteractiveTransition {
    
    let homeViewController: HomeViewController
    let discoveryHeaderViewController: DiscoveryHeaderViewController
    let discoveryViewController: DiscoveryViewController
    
    init(discoveryViewController: DiscoveryViewController,
         discoveryHeaderViewController: DiscoveryHeaderViewController,
         homeViewController: HomeViewController) {
        self.discoveryViewController = discoveryViewController
        self.discoveryHeaderViewController = discoveryHeaderViewController
        self.homeViewController = homeViewController
        super.init()
        self.discoveryHeaderViewController.view.addGestureRecognizer(
            UIPanGestureRecognizer(target: self, action: #selector(presentDiscoveryViewController(_:))))
    }
    
    @objc func presentDiscoveryViewController(_ gesture: UIPanGestureRecognizer) {
        let percent = gesture.translation(in: self.homeViewController.view).y /
            self.homeViewController.view.bounds.height
        
        switch gesture.state {
        case .began: self.discoveryViewController.dismiss(animated: true)
        case .changed: self.update(percent)
        case .ended: (percent > 0.5 || gesture.velocity(in: self.homeViewController.view).y > 0) ?
            self.finish() : self.cancel()
        default: break
        }
    }
    
}
