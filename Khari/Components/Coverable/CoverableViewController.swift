//
//  CollapsableSplitViewController.swift
//  Khari
//
//  Created by Evan Gruère on 27/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class CoverableViewController: UIViewController {
    
    var fullscreenViewController: UIViewController!
    var collapsableViewController: CollapsableViewController!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.addChild(self.fullscreenViewController)
        self.addChild(self.collapsableViewController)
        
        self.view.addSubview(self.fullscreenViewController.view)
        self.view.addSubview(self.collapsableViewController.view)
        
        self.fullscreenViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.fullscreenViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.fullscreenViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.fullscreenViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.fullscreenViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        self.fullscreenViewController.didMove(toParent: self)
        self.collapsableViewController.didMove(toParent: self)
        
    }
    
}
