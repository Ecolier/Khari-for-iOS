//
//  DiscoveryController.swift
//  Khari
//
//  Created by Evan Gruère on 23/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryViewController: CollapsableViewController {
    
    let discoveryView = DiscoveryView()
    
    override func loadView() {
        self.view = self.discoveryView
    }
    
}
