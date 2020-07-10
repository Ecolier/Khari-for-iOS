//
//  StrangerController.swift
//  Khari
//
//  Created by Evan Gruère on 01/05/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class StrangerViewController: DiscoveryViewController {
    
    let stranger: Stranger
    let user: User
    let strangerView = StrangerView()
    
    init(user: User, stranger: Stranger) {
        self.user = user
        self.stranger = stranger
        super.init(discoveryView: self.strangerView)
        
        self.discoveryView.headerView.usernameLabel.text = self.stranger.username
        (self.strangerView.blockButton.rightControl as! UISwitch).addTarget(self, action: #selector(switchHiddenMode), for: .valueChanged)
    }
    
    @objc func switchHiddenMode(switchView: UISwitch) {
        print(switchView)
        UserService.hideFromStranger(username: self.user.username, password: self.user.password, strangerUsername: self.stranger.username)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
