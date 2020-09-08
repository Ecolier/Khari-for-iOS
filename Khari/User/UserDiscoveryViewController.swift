//
//  UserDiscoveryViewController.swift
//  Khari
//
//  Created by Evan Gruère on 01/08/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class UserDiscoveryViewController: UIViewController {

    let userDiscoveryView = UserDiscoveryView()
    var user: User
    
    init(with user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.userDiscoveryView
    }
    
}
