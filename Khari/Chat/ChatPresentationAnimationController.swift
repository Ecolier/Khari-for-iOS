//
//  ChatPresentationAnimationController.swift
//  Khari
//
//  Created by Evan Gruère on 23/09/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class ChatPresentationAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? StrangerDiscoveryViewController,
              let toViewController = transitionContext.viewController(forKey: .to) as? ChatViewController else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       animations: {
                        toViewController.view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                       },
                       completion: { _ in
                        
                       })
            
            
            
    }
}
