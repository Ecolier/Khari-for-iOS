//
//  UserViewController.swift
//  Khari
//
//  Created by Evan Gruère on 08/12/2019.
//  Copyright © 2019 Evan Gruère. All rights reserved.
//

import UIKit
import Combine

class UserViewController: DiscoveryViewController {
    
    private var getHiddenStrangersCancellable: AnyCancellable!
    
    let user: User
    let userView = UserView()
    
    init(_ user: User) {
        self.user = user
        super.init(discoveryView: self.userView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userView.headerView.usernameLabel.text = self.user.username
        
        if self.user.hiddenFrom.count > 0 {
            self.userView.blockedLabel.text = "Blocked strangers"
            
            self.user.hiddenFrom.forEach { username in
                self.userView.addBlockedUser(username)
            }
        }
        
    }
    
}
