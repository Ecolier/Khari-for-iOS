//
//  UserViewController.swift
//  Khari
//
//  Created by Evan Gruère on 08/12/2019.
//  Copyright © 2019 Evan Gruère. All rights reserved.
//

import UIKit
import CoreLocation

class UserController: UIViewController {
    
    let userView = UserView()
    var managedUser = User() {
        didSet {
            self.userView.userHeader.usernameLabel.text = managedUser.username
        }
    }
    
    override func loadView() {
        self.view = self.userView
    }

}
