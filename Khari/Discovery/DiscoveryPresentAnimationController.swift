//
//  DiscoveryAnimationController.swift
//  Khari
//
//  Created by Evan Gruère on 02/09/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? HomeViewController,
            let toViewController = transitionContext.viewController(forKey: .to) as? DiscoveryViewController
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        let headerViewController = fromViewController.discoveryHeaderViewController
        
        let headerView = fromViewController.homeView.discoveryHeaderView
        let discoveryView = toViewController.discoveryView
        
        let originFrame = headerView.frame
        
        guard let headerSnapshot = headerViewController.view.snapshotView(afterScreenUpdates: true) else {
            return
        }
        
        containerView.addSubview(discoveryView)
        containerView.addSubview(headerSnapshot)
        
        headerSnapshot.frame.origin = originFrame.origin
        discoveryView.frame = CGRect(x: 0, y: headerSnapshot.frame.maxY, width: finalFrame.width, height: finalFrame.height)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            headerSnapshot.frame.origin.y = containerView.safeAreaInsets.top
            discoveryView.frame.origin.y = containerView.safeAreaInsets.top + headerSnapshot.bounds.height
        }, completion: { finished in
            if !transitionContext.transitionWasCancelled {
                headerSnapshot.removeFromSuperview()
                discoveryView.frame.origin.y = containerView.safeAreaInsets.top
                toViewController.setDiscoveryHeaderViewController(headerViewController)
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
}
