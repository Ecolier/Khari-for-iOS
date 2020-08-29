//
//  MessageView.swift
//  Khari
//
//  Created by Evan Gruère on 05/08/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class MessageView: UIView {
    
    let messageLabel = UILabel()
    let messageDirection: MessageDirection
    
    init(direction: MessageDirection) {
        self.messageDirection = direction
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 9
        
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.messageLabel)
        
        NSLayoutConstraint.activate([
            self.messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 9),
            self.bottomAnchor.constraint(equalTo: self.messageLabel.bottomAnchor, constant: 9),
        ])
        
        if messageDirection == .sent {
            self.backgroundColor = .systemBlue
            self.messageLabel.textColor = .white
            NSLayoutConstraint.activate([
                self.messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -9),
                self.leadingAnchor.constraint(equalTo: self.messageLabel.leadingAnchor, constant: -9)
            ])
            
        } else if messageDirection == .received {
            self.backgroundColor = .systemGray5
            self.messageLabel.textColor = .darkText
            NSLayoutConstraint.activate([
                self.messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 9),
                self.trailingAnchor.constraint(equalTo: self.messageLabel.trailingAnchor, constant: 9)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
