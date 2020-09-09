//
//  DiscoveryView.swift
//  Khari
//
//  Created by Evan Gruère on 23/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryView: UIView {
    
    var contentViewTopAnchor = NSLayoutConstraint()
    private(set) var discoveryHeaderView = DiscoveryHeaderView()
    private(set) var contentView = UIView()
    
    init() {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.08
        self.backgroundColor = .white
        
        self.addSubview(self.contentView)
        
        self.discoveryHeaderView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentViewTopAnchor = self.contentView.topAnchor.constraint(equalTo: self.topAnchor)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentViewTopAnchor,
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHeaderView(_ discoveryHeaderView: DiscoveryHeaderView) {
        self.addSubview(discoveryHeaderView)
        
        discoveryHeaderView.translatesAutoresizingMaskIntoConstraints = false
        discoveryHeaderView.layer.shadowColor = UIColor.clear.cgColor
        
        NSLayoutConstraint.activate([
            discoveryHeaderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            discoveryHeaderView.topAnchor.constraint(equalTo: self.topAnchor),
            discoveryHeaderView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.discoveryHeaderView = discoveryHeaderView
    }
    
    func setContentView(_ contentView: UIView) {
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: self.discoveryHeaderView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        self.contentView = contentView
    }
    
}
