//
//  CollapsableViewController.swift
//  Khari
//
//  Created by Evan Gruère on 26/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class CollapsableViewController: UIViewController {
    
    let collapsableView = CollapsableView()
    
    var managedViewController = UIViewController() {
        didSet {
            oldValue.willMove(toParent: nil)
            oldValue.view.removeFromSuperview()
            oldValue.removeFromParent()
            self.addChild(self.managedViewController)
            self.view.addSubview(self.managedViewController.view)
            self.managedViewController.didMove(toParent: self)
        }
    }
    
    override func loadView() {
        self.view = self.collapsableView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.managedViewController.view.frame = self.view.bounds
    }
}

