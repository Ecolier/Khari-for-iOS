//
//  MessageView.swift
//  Khari
//
//  Created by Evan Gruère on 02/08/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class MessageView: UIView {
    
    let messages = [UIMessage]
    let rulesLabel = UILabel()
    let composeView = UITextView()
    let sendIcon = UIImageView(image: UIImage(systemName: "arrow.up.circle.fill"))
    
    var lastKeyboardOffset: CGFloat = 0.0
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(self.rulesLabel)
        self.addSubview(self.composeView)
        self.addSubview(self.sendIcon)
        
        self.composeView.layer.cornerRadius = 6
        self.composeView.backgroundColor = .systemGray6
        self.composeView.font = .systemFont(ofSize: 16)
        self.composeView.textContainerInset = UIEdgeInsets(top: 15, left: 9, bottom: 12, right: 9)
        
        self.rulesLabel.textColor = .systemGray3
        self.rulesLabel.textAlignment = .center
        self.rulesLabel.numberOfLines = 0
        
        self.rulesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.composeView.translatesAutoresizingMaskIntoConstraints = false
        self.sendIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.rulesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.rulesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 48),
            self.rulesLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.75),
            
            self.composeView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18),
            self.composeView.heightAnchor.constraint(equalToConstant: 48),
            self.composeView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            self.composeView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            
            self.sendIcon.centerYAnchor.constraint(equalTo: self.composeView.centerYAnchor),
            self.sendIcon.trailingAnchor.constraint(equalTo: self.composeView.trailingAnchor, constant: -9),
            self.sendIcon.widthAnchor.constraint(equalToConstant: 36),
            self.sendIcon.heightAnchor.constraint(equalToConstant: 36),
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        lastKeyboardOffset = getKeyboardHeight(notification: notification)
        self.composeView.frame.origin.y -= lastKeyboardOffset
        self.sendIcon.frame.origin.y -= lastKeyboardOffset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.composeView.frame.origin.y += lastKeyboardOffset
        self.sendIcon.frame.origin.y += lastKeyboardOffset
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
