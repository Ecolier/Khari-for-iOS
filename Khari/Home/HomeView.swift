//
//  HomeView.swift
//  Khari
//
//  Created by Evan Gruère on 08/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    let collapsableView = CollapsableView()
    private var discoveryView = DiscoveryView()
    private var mapView = UIView()
    
    init() {
        super.init(frame: .zero)
        self.addSubview(self.collapsableView)
        self.collapsableView.layer.cornerRadius = 12
        self.collapsableView.layer.shadowColor = UIColor.black.cgColor
        self.collapsableView.layer.shadowRadius = 6
        self.collapsableView.layer.shadowOpacity = 0.08
        self.collapsableView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMapView(_ view: UIView) {
        self.mapView.removeFromSuperview()
        self.mapView = view
        self.addSubview(self.mapView)
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.mapView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func setDiscoveryView(_ view: DiscoveryView) {
        self.discoveryView.removeFromSuperview()
        self.discoveryView = view
        self.collapsableView.addSubview(self.discoveryView)
        self.bringSubviewToFront(self.collapsableView)
        self.discoveryView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.discoveryView.leadingAnchor.constraint(equalTo: self.collapsableView.leadingAnchor),
            self.discoveryView.trailingAnchor.constraint(equalTo: self.collapsableView.trailingAnchor),
            self.discoveryView.topAnchor.constraint(equalTo: self.collapsableView.topAnchor),
            self.discoveryView.bottomAnchor.constraint(equalTo: self.collapsableView.bottomAnchor),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.collapsableView.collapsedY = self.bounds.height - 130
        self.collapsableView.fullY = self.safeAreaInsets.top
        self.collapsableView.breakY = self.bounds.height / 2
        self.collapsableView.frame = CGRect(
            x: 0, y: self.bounds.height - 130,
            width: self.bounds.width, height: self.bounds.height - self.safeAreaInsets.top)
    }
    
}
