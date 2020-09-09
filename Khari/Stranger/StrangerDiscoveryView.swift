//
//  StrangerDiscoveryView.swift
//  Khari
//
//  Created by Evan Gruère on 08/09/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class StrangerDiscoveryView: DiscoveryView {
    
    let messageButton = StackButtonView(
        leftControl: UIImageView(image: UIImage(systemName: "message.fill")?.withTintColor(.systemGray4, renderingMode: .alwaysOriginal)),
        rightControl: UIImageView(image: UIImage(systemName: "chevron.right")?.withTintColor(.systemGray4, renderingMode: .alwaysOriginal))
    )
    
    let blockButton = StackButtonView(
        leftControl: UIImageView(image: UIImage(systemName: "location.fill")?.withTintColor(.systemGray4, renderingMode: .alwaysOriginal)),
        rightControl: UISwitch()
    )
    
    override init() {
        super.init()
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {

        self.messageButton.label.text = "Send a message"
        self.blockButton.label.text = "Block user from tracking"
        
        self.contentView.addSubview(self.messageButton)
        self.contentView.addSubview(self.blockButton)
    
        self.messageButton.translatesAutoresizingMaskIntoConstraints = false
        self.blockButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.messageButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 36),
            self.messageButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            self.messageButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            self.blockButton.topAnchor.constraint(equalTo: self.messageButton.bottomAnchor, constant: 24),
            self.blockButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            self.blockButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
    }
}
