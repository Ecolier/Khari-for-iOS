//
//  DiscoveryView.swift
//  Khari
//
//  Created by Evan Gruère on 23/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryView: UIView {
    
    let headerView = DiscoveryHeaderView()
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(self.headerView)
        
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.headerView.topAnchor.constraint(equalTo: self.topAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
