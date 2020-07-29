//
//  UserPicture.swift
//  Khari
//
//  Created by Evan Gruère on 29/01/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class UserPicture: UIView {
    
    private let circleLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
    
    private func initialize() {
        self.circleLayer.fillColor = UIColor.systemGray5.cgColor
        self.layer.addSublayer(self.circleLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.circleLayer.path = UIBezierPath(ovalIn: self.bounds).cgPath
    }
}
