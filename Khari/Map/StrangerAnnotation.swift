//
//  UserAnnotation.swift
//  Khari
//
//  Created by Evan Gruère on 22/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import Mapbox

class StrangerAnnotation: NSObject, MGLAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    
    let stranger: Stranger
    
    init(stranger: Stranger) {
        self.stranger = stranger
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
