//
//  HomeView.swift
//  Khari
//
//  Created by Evan Gruère on 08/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    var mapView: MapView! = MapView() {
        didSet {
            oldValue.removeFromSuperview()
            self.addSubview(self.mapView)
            self.mapView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.mapView.topAnchor.constraint(equalTo: self.topAnchor),
                self.mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        }
    }
    
    var discoveryView: DiscoveryView! = DiscoveryView() {
        didSet {
            oldValue.removeFromSuperview()
            self.addSubview(self.discoveryView)
            self.discoveryView.layer.cornerRadius = 12
            self.discoveryView.layer.shadowColor = UIColor.black.cgColor
            self.discoveryView.layer.shadowRadius = 6
            self.discoveryView.layer.shadowOpacity = 0.08
            self.discoveryView.backgroundColor = .white
            self.discoveryView.containerFrame = UIScreen.main.bounds.divided(atDistance: self.safeAreaInsets.top,
                from: .minYEdge).remainder
            self.discoveryView.setNeedsLayout()
            self.discoveryView.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.discoveryView.minHeight = self.discoveryView.discoveryHeaderView.bounds.height
        self.discoveryView.frame = self.bounds.divided(atDistance: self.safeAreaInsets.top,
        from: .minYEdge).remainder
    }

}
