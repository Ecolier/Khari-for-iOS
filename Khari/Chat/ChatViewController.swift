//
//  MessageViewController.swift
//  Khari
//
//  Created by Evan Gruère on 19/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit
import Combine

class MessageViewController: UIViewController {
    
    private var messageReceivedCancellable: AnyCancellable!
    
    let messageView = MessageView()
    let target: String
    
    init(target: String) {
        self.target = target
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.messageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messageReceivedCancellable = SocketManager.shared().onMessageReceived.sink { message in 
            print(message)
        }
        
        self.messageView.rulesLabel.text = "You can send one and only one message to this person"
        self.messageView.sendIcon.isUserInteractionEnabled = true
        self.messageView.sendIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendMessage)))
    }
    
    @objc func sendMessage() {
        guard let token = AuthenticationRepository.fetchToken() else { return }
        SocketManager.shared().sendMessage(token: token, target: self.target, message: self.messageView.composeView.text)
    }
}
