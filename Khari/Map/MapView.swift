//
//  MapView.swift
//  Khari
//
//  Created by Evan Gruère on 05/12/2019.
//  Copyright © 2019 Evan Gruère. All rights reserved.
//

import SwiftUI
import Mapbox

class MapView: MGLMapView {
    
    init() {
        super.init(frame: .zero, styleURL: MGLStyle.streetsStyleURL)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
    
    private func initialize() {
        self.setUserTrackingMode(.follow, animated: false) { }
        self.isPitchEnabled = false
        self.isRotateEnabled = false
        self.isScrollEnabled = false
        self.compassView.isHidden = true
        self.zoomLevel = 14
    }
    
}
