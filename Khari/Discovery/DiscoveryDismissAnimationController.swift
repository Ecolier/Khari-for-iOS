//
//  DiscoveryAnimationController.swift
//  Khari
//
//  Created by Evan Gruère on 02/09/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let homeViewController: HomeViewController
    
    init(homeViewController: HomeViewController) {
        self.homeViewController = homeViewController
        super.init()
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(
            forKey: .from) as? DiscoveryViewController else {
                return
        }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(fromViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            fromViewController.view.frame.origin.y = containerView.bounds.height - (fromViewController.view as! StrangerDiscoveryView).discoveryHeaderView.bounds.height
            
        }, completion: { finished in
            
            if !transitionContext.transitionWasCancelled {
                
                self.homeViewController.setDiscoveryHeaderViewController(fromViewController.discoveryHeaderViewController)
            }
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
}
