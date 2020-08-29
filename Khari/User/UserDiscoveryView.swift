//
//  UserDiscoveryView.swift
//  Khari
//
//  Created by Evan Gruère on 18/08/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class UserDiscoveryView: DiscoveryView {
    
    let userView = UserView()
    
    override init() {
        super.init()
        self.addSubview(userView)
        self.userView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.userView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.userView.topAnchor.constraint(equalTo: self.discoveryHeaderView.bottomAnchor),
            self.userView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.userView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
