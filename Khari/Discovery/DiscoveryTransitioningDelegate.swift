//
//  DiscoveryTransitioningDelegate.swift
//  Khari
//
//  Created by Evan Gruère on 02/09/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

extension DiscoveryViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DiscoveryPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DiscoveryPresentAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
        return DiscoveryDismissAnimationController(homeViewController: dismissed.presentingViewController as! HomeViewController)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning)
    -> UIViewControllerInteractiveTransitioning? {
        return self.presentInteractionController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning)
    -> UIViewControllerInteractiveTransitioning? {
        return self.dismissInteractionController
    }
}
