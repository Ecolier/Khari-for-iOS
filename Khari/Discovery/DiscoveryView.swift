//
//  DiscoveryView.swift
//  Khari
//
//  Created by Evan Gruère on 23/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryView: CollapsableView {
    
    var discoveryHeaderView = DiscoveryHeaderView()
    
    var contentView = UIView() {
        didSet {
            oldValue.removeFromSuperview()
            self.addSubview(self.contentView)
            self.contentView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.contentView.topAnchor.constraint(equalTo: self.discoveryHeaderView.bottomAnchor),
                self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        }
    }
    
    override init() {
        super.init()
        self.addSubview(self.discoveryHeaderView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.discoveryHeaderView.frame.size.width = self.bounds.width
    }
    
}
