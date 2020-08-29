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
    let strangerView = StrangerView()
    
    var stranger: Stranger
    
    init(stranger: Stranger) {
        self.stranger = stranger
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.strangerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (self.strangerView.blockButton.rightControl as! UISwitch).addTarget(self, action: #selector(switchHiddenMode),
                                                                            for: .valueChanged)
        
        guard let token = AuthenticationRepository.fetchToken() else { return }
        
        self.isHiddenCancellable = PrivacyService.isHiddenFrom(token: token,
                                 strangerUsername: self.stranger.username)
            .sink { hidden in
                hidden ? (self.strangerView.blockButton.rightControl as! UISwitch).setOn(true, animated: false) :
                    (self.strangerView.blockButton.rightControl as! UISwitch).setOn(false, animated: false)
        }
    }
    
    @objc func switchHiddenMode(switchView: UISwitch) {
        
        guard let token = AuthenticationRepository.fetchToken() else { return }
        
        if switchView.isOn {
            PrivacyService.setHiddenFrom(token: token, strangerUsername: self.stranger.username)
        } else {
            PrivacyService.setVisibleTo(token: token, strangerUsername: self.stranger.username)
        }
    }
}
