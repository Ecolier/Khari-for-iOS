//
//  StrangerDiscoveryViewController.swift
//  Khari
//
//  Created by Evan Gruère on 01/08/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class StrangerDiscoveryViewController: DiscoveryViewController {
    
    let stranger: Stranger
    let strangerView = StrangerView()
    
    var chatViewController: ChatViewController?
    
    init(with stranger: Stranger) {
        self.stranger = stranger
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.discoveryView.onPanDown = {
            if let chatViewController = self.chatViewController {
                let composeView = chatViewController.chatView.composeView
                if composeView.isFirstResponder {
                    composeView.resignFirstResponder()
                }
            }
        }
        
        self.discoveryView.contentView = self.strangerView

        self.strangerView.messageButton
            .addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMessageController)))
        
        self.discoveryView.discoveryHeaderView.usernameLabel.text = self.stranger.username
    }
    
    @objc func showMessageController(sender: UITapGestureRecognizer) {
        self.strangerView.removeFromSuperview()
        let chatViewController = ChatViewController(target: self.stranger.username)
        self.addChild(chatViewController)
        self.discoveryView.contentView = chatViewController.view
        chatViewController.didMove(toParent: self)
        self.chatViewController = chatViewController
    }
}
