//
//  DiscoveryView.swift
//  Khari
//
//  Created by Evan Gruère on 23/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryView: UIView {
    
    private var contentViewTopAnchor = NSLayoutConstraint()
    
    private(set) var discoveryHeaderView: DiscoveryHeaderView?
    private(set) var contentView: UIView?
    
    init() {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.08
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHeaderView(_ discoveryHeaderView: DiscoveryHeaderView) {
        self.addSubview(discoveryHeaderView)
        
        discoveryHeaderView.translatesAutoresizingMaskIntoConstraints = false
        discoveryHeaderView.layer.shadowColor = UIColor.clear.cgColor
        
        self.contentViewTopAnchor.isActive = false
        if let contentView = self.contentView {
            self.contentViewTopAnchor = contentView.topAnchor.constraint(equalTo: discoveryHeaderView.topAnchor)
        }
        
        NSLayoutConstraint.activate([
            discoveryHeaderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            discoveryHeaderView.topAnchor.constraint(equalTo: self.topAnchor),
            discoveryHeaderView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.discoveryHeaderView = discoveryHeaderView
    }
    
}
