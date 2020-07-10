//
//  StackButtonView.swift
//  Khari
//
//  Created by Evan Gruère on 07/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class StackButtonView: UIView {
    
    var leftControl: UIView
    var rightControl: UIView
    let label = UILabel()
    let divider = UIView()
    
    init(leftControl: UIView, rightControl: UIView) {
        
        self.leftControl = leftControl
        self.rightControl = rightControl
        
        super.init(frame: .zero)
        
        self.addSubview(self.leftControl)
        self.addSubview(self.label)
        self.addSubview(self.divider)
        self.addSubview(self.rightControl)
        
        self.divider.backgroundColor = UIColor.systemGray5
        
        self.leftControl.translatesAutoresizingMaskIntoConstraints = false
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.divider.translatesAutoresizingMaskIntoConstraints = false
        self.rightControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.leftControl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.leftControl.topAnchor.constraint(equalTo: self.topAnchor),
            
            self.label.leadingAnchor.constraint(equalTo: self.leftControl.trailingAnchor, constant: 12),
            self.label.centerYAnchor.constraint(equalTo: self.leftControl.centerYAnchor),
            
            self.rightControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.rightControl.centerYAnchor.constraint(equalTo: self.leftControl.centerYAnchor),
            
            self.divider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.divider.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 12),
            self.divider.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.divider.heightAnchor.constraint(equalToConstant: 1),
            
            self.bottomAnchor.constraint(equalTo: self.divider.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
