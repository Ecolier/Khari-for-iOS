//
//  UserView.swift
//  Khari
//
//  Created by Evan Gruère on 05/12/2019.
//  Copyright © 2019 Evan Gruère. All rights reserved.
//

import UIKit

class UserView: UIView {
    
    let blockedLabel = UILabel()
    private var blockedUsers: [StackButtonView] = []
    
    init() {
        super.init(frame: .zero)
        
        self.blockedLabel.font = .boldSystemFont(ofSize: 24)
        
        self.addSubview(self.blockedLabel)
        
        self.blockedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.blockedLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            self.blockedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
        ])
    }
    
    func addBlockedUser(_ username: String) {
        let blockedStranger = StackButtonView(
            leftControl: UserPicture(),
            rightControl: UIImageView(image: UIImage(systemName: "chevron.right")))
        blockedStranger.label.text = username
        blockedStranger.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(blockedStranger)
        
        if blockedUsers.count == 0 {
            NSLayoutConstraint.activate([
                blockedStranger.topAnchor.constraint(equalTo: self.blockedLabel.bottomAnchor, constant: 18)
            ])
        } else {
            NSLayoutConstraint.activate([
                blockedStranger.topAnchor.constraint(equalTo: blockedUsers.last!.bottomAnchor, constant: 18)
            ])
        }
        
        NSLayoutConstraint.activate([
            blockedStranger.leftControl.widthAnchor.constraint(equalToConstant: 18),
            blockedStranger.leftControl.heightAnchor.constraint(equalToConstant: 18),
            blockedStranger.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            blockedStranger.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        self.blockedUsers.append(blockedStranger)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
