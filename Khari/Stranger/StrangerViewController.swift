//
//  StrangerController.swift
//  Khari
//
//  Created by Evan Gruère on 01/05/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit
import Combine

class StrangerViewController: DiscoveryViewController {
    
    private var isHiddenCancellable: AnyCancellable!
    
    let stranger: Stranger
    let user: User
    let strangerView = StrangerView()
    
    init(user: User, stranger: Stranger) {
        self.user = user
        self.stranger = stranger
        super.init(discoveryView: self.strangerView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.discoveryView.headerView.usernameLabel.text = self.stranger.username
        (self.strangerView.blockButton.rightControl as! UISwitch).addTarget(self, action: #selector(switchHiddenMode),
                                                                            for: .valueChanged)
        
        self.isHiddenCancellable = PrivacyService.isHiddenFrom(username: self.user.username,
                                 password: self.user.password,
                                 strangerUsername: self.stranger.username)
            .sink { hidden in
                hidden ? (self.strangerView.blockButton.rightControl as! UISwitch).setOn(true, animated: false) :
                    (self.strangerView.blockButton.rightControl as! UISwitch).setOn(false, animated: false)
        }
    }
    
    @objc func switchHiddenMode(switchView: UISwitch) {
        if switchView.isOn {
            PrivacyService.setHiddenFrom(username: self.user.username, password: self.user.password,
                                      strangerUsername: self.stranger.username)
        } else {
            PrivacyService.setVisibleTo(username: self.user.username, password: self.user.password,
                                     strangerUsername: self.stranger.username)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
