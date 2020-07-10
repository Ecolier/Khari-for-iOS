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
    var discoveryView = DiscoveryView() {
        didSet {
            oldValue.removeFromSuperview()
            self.collapsableView.addSubview(self.discoveryView)
            NSLayoutConstraint.activate([
                self.discoveryView.leadingAnchor.constraint(equalTo: self.collapsableView.leadingAnchor),
                self.discoveryView.trailingAnchor.constraint(equalTo: self.collapsableView.trailingAnchor),
                self.discoveryView.topAnchor.constraint(equalTo: self.collapsableView.topAnchor),
                self.discoveryView.bottomAnchor.constraint(equalTo: self.collapsableView.bottomAnchor),
            ])
        }
    }
    let mapView: MapView
    
    init(mapView: MapView) {
        
        self.mapView = mapView
        
        super.init(frame: .zero)
        
        self.collapsableView.layer.cornerRadius = 12
        self.collapsableView.backgroundColor = .white
        
        self.addSubview(self.mapView)
        self.addSubview(self.collapsableView)
        
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.mapView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        if self.discoveryView.headerView.frame != .zero {
            self.collapsableView.collapsedY = self.bounds.height - self.discoveryView.headerView.frame.height
            self.collapsableView.fullY = self.safeAreaInsets.top
            self.collapsableView.breakY = self.bounds.height / 2
            self.collapsableView.frame = CGRect(
                x: 0, y: self.bounds.height - self.discoveryView.headerView.frame.height,
                width: self.bounds.width, height: self.bounds.height - self.safeAreaInsets.top)
        }
        
        
    }

}
