//
//  MessageViewController.swift
//  Khari
//
//  Created by Evan Gruère on 19/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit
import Combine

class ChatViewController: UIViewController {
    
    private var messageReceivedCancellable: AnyCancellable!
    
    let chatView = ChatView()
    let target: String
    
    init(target: String) {
        self.target = target
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.chatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messageReceivedCancellable = SocketManager.shared().onMessageReceived.sink { message in
            self.chatView.addMessage(message, direction: .received)
        }
        
        self.chatView.rulesLabel.text = "You can send one and only one message to this person"
        self.chatView.messageListView.keyboardDismissMode = .interactive
        self.chatView.composeView.sendIcon.isUserInteractionEnabled = true
        self.chatView.composeView.sendIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendMessage)))
    }
    
    @objc func sendMessage() {
        if self.chatView.composeView.text.isEmpty {
            return
        }
        guard let token = AuthenticationRepository.fetchToken() else { return }
        SocketManager.shared().sendMessage(token: token, target: self.target, message: self.chatView.composeView.text!)
        self.chatView.addMessage(self.chatView.composeView.text!, direction: .sent)
        self.chatView.composeView.text.removeAll()
    }
}
