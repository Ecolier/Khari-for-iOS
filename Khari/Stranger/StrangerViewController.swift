//
//  StrangerController.swift
//  Khari
//
//  Created by Evan Gruère on 01/05/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit
import Combine

class StrangerViewController: UIViewController {
    
    private var isHiddenCancellable: AnyCancellable!
    
    let stranger: Stranger
    let token: String
    let user: User
    let strangerView = StrangerView()
    
    init(token: String, user: User, stranger: Stranger) {
        self.token = token
        self.user = user
        self.stranger = stranger
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (self.strangerView.blockButton.rightControl as! UISwitch).addTarget(self, action: #selector(switchHiddenMode),
                                                                            for: .valueChanged)
        
        self.isHiddenCancellable = PrivacyService.isHiddenFrom(token: self.token,
                                 strangerUsername: self.stranger.username)
            .sink { hidden in
                hidden ? (self.strangerView.blockButton.rightControl as! UISwitch).setOn(true, animated: false) :
                    (self.strangerView.blockButton.rightControl as! UISwitch).setOn(false, animated: false)
        }
    }
    
    @objc func switchHiddenMode(switchView: UISwitch) {
        if switchView.isOn {
            PrivacyService.setHiddenFrom(token: self.token, strangerUsername: self.stranger.username)
        } else {
            PrivacyService.setVisibleTo(token: self.token, strangerUsername: self.stranger.username)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
