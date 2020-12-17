//
//  ChatTransitioningDelegate.swift
//  Khari
//
//  Created by Evan Gruère on 23/09/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

extension ChatViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ChatPresentationAnimationController()
    }
}

