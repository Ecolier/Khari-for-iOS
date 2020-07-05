//
//  StrangerController.swift
//  Khari
//
//  Created by Evan Gruère on 01/05/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class StrangerController: UIViewController {
    
    let strangerView = StrangerView()
    
    var managedStranger = Stranger() {
        didSet {
            self.strangerView.userHeader.usernameLabel.text = managedStranger.identifier
        }
    }
    
    override func loadView() {
        self.view = self.strangerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
