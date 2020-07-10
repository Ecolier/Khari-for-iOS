//
//  UserHeader.swift
//  Khari
//
//  Created by Evan Gruère on 29/01/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryHeaderView: UIView {
    
    let touchIndicator = TouchIndicatorView()
    let userPicture = UserPicture()
    let usernameLabel = UILabel()
    
    private let topMargin: CGFloat = 6
    private let touchIndicatorBottomMargin: CGFloat = 12
    private let bottomMargin: CGFloat = 16
    private let userPictureSize: CGFloat = 72
    private let usernameLabelTopMargin: CGFloat = 6
    
    init() {
        super.init(frame: .zero)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
    
    private func initialize() {
        
        self.addSubview(self.touchIndicator)
        self.addSubview(self.userPicture)
        self.addSubview(self.usernameLabel)
        
        self.touchIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.userPicture.translatesAutoresizingMaskIntoConstraints = false
        self.usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.touchIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.touchIndicator.topAnchor.constraint(equalTo: self.topAnchor, constant: self.topMargin),
            self.touchIndicator.widthAnchor.constraint(equalToConstant: 42),
            self.touchIndicator.heightAnchor.constraint(equalToConstant: 6),
            
            self.userPicture.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.userPicture.topAnchor.constraint(equalTo: self.touchIndicator.bottomAnchor, constant: self.touchIndicatorBottomMargin),
            self.userPicture.widthAnchor.constraint(equalToConstant: self.userPictureSize),
            self.userPicture.heightAnchor.constraint(equalToConstant: self.userPictureSize),
            
            self.usernameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.usernameLabel.topAnchor.constraint(equalTo: self.userPicture.bottomAnchor, constant: self.usernameLabelTopMargin),
            
            self.bottomAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: self.bottomMargin)
            
        ])
    }
    
}
