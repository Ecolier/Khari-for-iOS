//
//  StrangerDiscoveryViewController.swift
//  Khari
//
//  Created by Evan Gruère on 01/08/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit
import Combine

class StrangerDiscoveryViewController: DiscoveryViewController {
    
    var isHiddenCancellable: AnyCancellable!
    
    let stranger: Stranger
    
    let strangerDiscoveryView = StrangerDiscoveryView()
    var chatViewController: ChatViewController?
    var topMargin = NSLayoutConstraint()
    
    init(with stranger: Stranger) {
        self.stranger = stranger
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.strangerDiscoveryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.strangerDiscoveryView.messageButton
            .addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMessageController)))
        
        (self.strangerDiscoveryView.blockButton.rightControl as! UISwitch).addTarget(self, action: #selector(switchHiddenMode),
                                                                  for: .valueChanged)
        
        guard let token = AuthenticationRepository.fetchToken() else { return }
        
        self.isHiddenCancellable = PrivacyService.isHiddenFrom(token: token,
                                                               strangerUsername: self.stranger.username)
            .sink { hidden in
                hidden ? (self.strangerDiscoveryView.blockButton.rightControl as! UISwitch).setOn(true, animated: false) :
                    (self.strangerDiscoveryView.blockButton.rightControl as! UISwitch).setOn(false, animated: false)
            }
    }
    
    @objc func showMessageController(sender: UITapGestureRecognizer) {
        let chatViewController = ChatViewController(target: self.stranger.username)
        self.present(chatViewController, animated: true)
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
