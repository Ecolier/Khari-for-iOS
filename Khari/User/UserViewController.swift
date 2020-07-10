//
//  UserViewController.swift
//  Khari
//
//  Created by Evan Gruère on 08/12/2019.
//  Copyright © 2019 Evan Gruère. All rights reserved.
//

import UIKit
import CoreLocation

class UserViewController: DiscoveryViewController {
    
    let user: User
    
    init(_ user: User) {
        self.user = user
        super.init(discoveryView: UserView())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.discoveryView.headerView.usernameLabel.text = self.user.username
    }

}
