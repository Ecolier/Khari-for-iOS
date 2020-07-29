//
//  StrangerView.swift
//  Khari
//
//  Created by Evan Gruère on 23/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class StrangerView: UIView {
    
    let messageButton = StackButtonView(
        leftControl: UIImageView(image: UIImage(systemName: "message.fill")?.withTintColor(.systemGray4, renderingMode: .alwaysOriginal)),
        rightControl: UIImageView(image: UIImage(systemName: "chevron.right")?.withTintColor(.systemGray4, renderingMode: .alwaysOriginal))
    )
    
    let blockButton = StackButtonView(
        leftControl: UIImageView(image: UIImage(systemName: "location.fill")?.withTintColor(.systemGray4, renderingMode: .alwaysOriginal)),
        rightControl: UISwitch()
    )
    
    init() {
        super.init(frame: .zero)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
    
    private func initialize() {

        self.messageButton.label.text = "Send a message"
        self.blockButton.label.text = "Block user from tracking"
        
        self.addSubview(self.messageButton)
        self.addSubview(self.blockButton)
    
        self.messageButton.translatesAutoresizingMaskIntoConstraints = false
        self.blockButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.messageButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 36),
            self.messageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.messageButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.blockButton.topAnchor.constraint(equalTo: self.messageButton.bottomAnchor, constant: 24),
            self.blockButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.blockButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }

}

