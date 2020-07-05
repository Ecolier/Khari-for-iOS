//
//  UserView.swift
//  Khari
//
//  Created by Evan Gruère on 05/12/2019.
//  Copyright © 2019 Evan Gruère. All rights reserved.
//

import UIKit

class UserView: UIView {
    
    let userHeader = UserHeader()
    
    init() {
        super.init(frame: .zero)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
    
    private func initialize() {
        
        self.addSubview(self.userHeader)
        
        self.userHeader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.userHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.userHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.userHeader.topAnchor.constraint(equalTo: self.topAnchor),
        ])
    }

}
