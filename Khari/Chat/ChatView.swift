//
//  MessageView.swift
//  Khari
//
//  Created by Evan Gruère on 02/08/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

enum MessageDirection {
    case received
    case sent
}

class ChatView: UIView {
    
    let messageListView = MessageListView()
    let rulesLabel = UILabel()
    let composeView = ComposeView()
    
    private var composeViewBottomAnchor: NSLayoutConstraint!
    
    var lastKeyboardOffset: CGFloat = 0.0
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(self.rulesLabel)
        self.addSubview(self.composeView)
        
        self.composeView.layer.cornerRadius = 6
        self.composeView.backgroundColor = .systemGray6
        self.composeView.font = .systemFont(ofSize: 16)
        
        self.rulesLabel.textColor = .systemGray3
        self.rulesLabel.textAlignment = .center
        self.rulesLabel.numberOfLines = 0
        
        self.rulesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.composeView.translatesAutoresizingMaskIntoConstraints = false
        self.messageListView.translatesAutoresizingMaskIntoConstraints = false
        
        self.composeViewBottomAnchor = self.composeView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18)
        
        NSLayoutConstraint.activate([
            self.rulesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.rulesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 48),
            self.rulesLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.75),
            
            self.composeViewBottomAnchor,
            self.composeView.heightAnchor.constraint(equalToConstant: 48),
            self.composeView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            self.composeView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func addMessage(_ message: String, direction: MessageDirection) {
        if rulesLabel.superview == self {
            rulesLabel.removeFromSuperview()
            self.addSubview(self.messageListView)
            NSLayoutConstraint.activate([
                self.messageListView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.messageListView.topAnchor.constraint(equalTo: self.topAnchor),
                self.messageListView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.messageListView.bottomAnchor.constraint(equalTo: self.composeView.topAnchor, constant: -18)
            ])
        }
        self.messageListView.addMessage(message, direction: direction)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        lastKeyboardOffset = getKeyboardHeight(notification: notification)
        self.composeViewBottomAnchor.constant -= lastKeyboardOffset
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.composeViewBottomAnchor.constant += lastKeyboardOffset
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
