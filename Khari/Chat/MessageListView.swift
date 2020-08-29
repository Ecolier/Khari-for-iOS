//
//  MessageListView.swift
//  Khari
//
//  Created by Evan Gruère on 06/08/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class MessageListView: UIScrollView {
    
    let contentView = UIView()
    
    private var contentViewBottomAnchor = NSLayoutConstraint()
    
    var messages = [MessageView]()
    
    init() {
        super.init(frame: .zero)
        self.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentViewBottomAnchor = self.contentView.bottomAnchor.constraint(equalTo: self.frameLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.frameLayoutGuide.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.frameLayoutGuide.leadingAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.frameLayoutGuide.widthAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.frameLayoutGuide.bottomAnchor),
            self.contentViewBottomAnchor
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addMessage(_ message: String, direction: MessageDirection) {
        
        let messageView = MessageView(direction: direction)
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageView.messageLabel.text = message
        
        self.contentView.addSubview(messageView)
        
        self.contentViewBottomAnchor.isActive = false
        self.contentViewBottomAnchor = self.bottomAnchor.constraint(equalTo: messageView.bottomAnchor)
        self.contentViewBottomAnchor.isActive = true
        
        if self.messages.isEmpty {
            messageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 48).isActive = true
        } else {
            let lastMessageView = self.messages.last!
            messageView.topAnchor.constraint(equalTo: lastMessageView.topAnchor, constant: 48).isActive = true
        }
        
        if direction == .received {
            messageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 18).isActive = true
        } else if direction == .sent {
            messageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -18).isActive = true
        }
        
        self.messages.append(messageView)
    }
    
}
