//
//  HeaderViewController.swift
//  Khari
//
//  Created by Evan Gruère on 23/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryHeaderViewController: UIViewController {
    
    let headerView = DiscoveryHeaderView()
    
    var username: String = "" {
        didSet {
            self.headerView.usernameLabel.text = self.username
            self.headerView.setNeedsLayout()
        }
    }
    
    override func loadView() {
        self.view = headerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
