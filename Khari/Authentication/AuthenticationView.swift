//
//  AuthenticationView.swift
//  Khari
//
//  Created by Evan Gruère on 16/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class AuthenticationView: UIView {
    
    private let buttonHeight: CGFloat = 60
    private let buttonSpacing: CGFloat = 12
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let anonymousLoginButton = AuthenticationButton()
    let facebookLoginButton = AuthenticationButton()
    let googleLoginButton = AuthenticationButton()
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemBackground
        
        self.titleLabel.font = .boldSystemFont(ofSize: 24)
        
        self.anonymousLoginButton.backgroundColor = .systemGray5
        self.anonymousLoginButton.setTitleColor(.systemGray, for: .normal)
        
        self.facebookLoginButton.backgroundColor = .systemBlue
        self.facebookLoginButton.setTitleColor(.systemGray6, for: .normal)
        
        self.googleLoginButton.backgroundColor = .systemRed
        self.googleLoginButton.setTitleColor(.systemGray6, for: .normal)
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)
        self.addSubview(self.anonymousLoginButton)
        self.addSubview(self.facebookLoginButton)
        self.addSubview(self.googleLoginButton)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.anonymousLoginButton.translatesAutoresizingMaskIntoConstraints = false
        self.facebookLoginButton.translatesAutoresizingMaskIntoConstraints = false
        self.googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 48),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 6),
            self.subtitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.anonymousLoginButton.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 48),
            self.anonymousLoginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.anonymousLoginButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            self.anonymousLoginButton.heightAnchor.constraint(equalToConstant: self.buttonHeight),
            
            self.facebookLoginButton.topAnchor.constraint(equalTo: self.anonymousLoginButton.bottomAnchor, constant: self.buttonSpacing),
            self.facebookLoginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.facebookLoginButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            self.facebookLoginButton.heightAnchor.constraint(equalToConstant: self.buttonHeight),
            
            self.googleLoginButton.topAnchor.constraint(equalTo: self.facebookLoginButton.bottomAnchor, constant: self.buttonSpacing),
            self.googleLoginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.googleLoginButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            self.googleLoginButton.heightAnchor.constraint(equalToConstant: self.buttonHeight),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
