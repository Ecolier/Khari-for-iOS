//
//  StrangerAnnotationView.swift
//  Khari
//
//  Created by Evan Gruère on 10/09/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import Mapbox

class StrangerAnnotationView: MGLAnnotationView {
    
    let size: CGFloat = 32
    let picture = UserPicture()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.bounds = CGRect(x: 0, y: 0, width: self.size, height: self.size)
        self.addSubview(self.picture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.picture.frame = self.bounds
        
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }
}
