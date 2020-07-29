//
//  UserDetailsViewController.swift
//  Khari
//
//  Created by Evan Gruère on 19/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit
import Combine

class UserDetailsViewController: UIViewController {
    
    private var getHiddenStrangersCancellable: AnyCancellable!
    
    var user: User!
    let userView = UserView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.user.hiddenFrom.count > 0 {
            self.userView.blockedLabel.text = "Blocked strangers"
            
            self.user.hiddenFrom.forEach { username in
                self.userView.addBlockedUser(username)
            }
        }
        
    }
    
}
