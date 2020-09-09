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
            let toViewController = transitionContext.viewController(forKey: .to) as? DiscoveryViewController,
            let toView = transitionContext.view(forKey: .to) as? DiscoveryView
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        let headerViewController = fromViewController.discoveryHeaderViewController
        
        let headerView = fromViewController.homeView.discoveryHeaderView
        
        let originFrame = headerView.frame
        
        guard let headerSnapshot = headerViewController.view.snapshotView(afterScreenUpdates: true) else {
            return
        }
        
        containerView.addSubview(toView)
        toView.addSubview(headerSnapshot)
        
        toView.frame = CGRect(origin: originFrame.origin, size: finalFrame.size)
        toView.contentViewTopAnchor.constant = headerSnapshot.frame.height
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.frame.origin.y = containerView.safeAreaInsets.top
        }, completion: { finished in
            if !transitionContext.transitionWasCancelled {
                headerSnapshot.removeFromSuperview()
                toViewController.setDiscoveryHeaderViewController(headerViewController)
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
}
