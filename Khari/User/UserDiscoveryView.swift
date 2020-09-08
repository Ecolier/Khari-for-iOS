//
//  UserDiscoveryView.swift
//  Khari
//
//  Created by Evan Gruère on 18/08/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class UserDiscoveryView: UIView {
    
    let userView = UserView()
    
    init() {
        super.init(frame: .zero)
        self.addSubview(userView)
        self.userView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.userView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.userView.topAnchor.constraint(equalTo: self.bottomAnchor),
            self.userView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.userView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
