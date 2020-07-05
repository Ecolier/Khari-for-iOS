//
//  UserHeader.swift
//  Khari
//
//  Created by Evan Gruère on 29/01/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class UserHeader: UIView {
    
    var onDidLayoutSubviews: (UIView) -> Void = { _ in }
    
    let userPicture = UserPicture()
    let usernameLabel = UILabel()
    
    private let topMargin: CGFloat = 16
    private let bottomMargin: CGFloat = 16
    private let userPictureSize: CGFloat = 72
    private let usernameLabelTopMargin: CGFloat = 8
    
    init() {
        super.init(frame: .zero)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
    
    private func initialize() {
        
        self.addSubview(self.userPicture)
        self.addSubview(self.usernameLabel)
        
        self.userPicture.translatesAutoresizingMaskIntoConstraints = false
        self.usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.userPicture.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.userPicture.topAnchor.constraint(equalTo: self.topAnchor, constant: self.topMargin),
            self.userPicture.widthAnchor.constraint(equalToConstant: self.userPictureSize),
            self.userPicture.heightAnchor.constraint(equalToConstant: self.userPictureSize),
            
            self.usernameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.usernameLabel.topAnchor.constraint(equalTo: self.userPicture.bottomAnchor, constant: self.usernameLabelTopMargin),
            
            self.bottomAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: self.bottomMargin)
            
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.onDidLayoutSubviews(self)
    }
    
}
