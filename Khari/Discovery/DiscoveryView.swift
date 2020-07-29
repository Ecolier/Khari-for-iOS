//
//  DiscoveryView.swift
//  Khari
//
//  Created by Evan Gruère on 23/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryView: UIView {
    
    private(set) var discoveryHeaderView = DiscoveryHeaderView()
    private(set) var userView = UIView()
    
    func setDiscoveryHeaderView(_ view: DiscoveryHeaderView) {
        self.discoveryHeaderView.removeFromSuperview()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        self.discoveryHeaderView = view
    }
    
    func setUserView(_ view: UIView) {
        self.userView.removeFromSuperview()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.topAnchor.constraint(equalTo: self.discoveryHeaderView.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        self.userView = view
    }
    
}
