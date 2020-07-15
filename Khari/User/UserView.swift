//
//  UserView.swift
//  Khari
//
//  Created by Evan Gruère on 05/12/2019.
//  Copyright © 2019 Evan Gruère. All rights reserved.
//

import UIKit

class UserView: DiscoveryView {
    
    let blockedLabel = UILabel()
    
    override init() {
        super.init()
        
        self.addSubview(self.blockedLabel)
        
        self.blockedLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
