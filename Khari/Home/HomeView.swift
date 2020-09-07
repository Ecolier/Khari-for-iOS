//
//  HomeView.swift
//  Khari
//
//  Created by Evan Gruère on 08/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    var mapView: MapView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let mapView = self.mapView {
                self.addSubview(mapView)
                mapView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    mapView.topAnchor.constraint(equalTo: self.topAnchor),
                    mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                    mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                ])
            }
        }
    }
    
    private(set) var discoveryHeaderView = DiscoveryHeaderView()
    
    func setDiscoveryHeaderView(_ discoveryHeaderView: DiscoveryHeaderView) {
        self.addSubview(discoveryHeaderView)
        discoveryHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            discoveryHeaderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            discoveryHeaderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            discoveryHeaderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            discoveryHeaderView.heightAnchor.constraint(equalToConstant: 130)
        ])
        self.discoveryHeaderView = discoveryHeaderView
    }
    
}
