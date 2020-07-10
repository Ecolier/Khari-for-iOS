//
//  LaunchView.swift
//  Khari
//
//  Created by Evan Gruère on 07/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class LaunchView: UIView {
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        
        self.activityIndicator.startAnimating()
        self.addSubview(self.activityIndicator)
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
