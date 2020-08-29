//
//  DiscoveryViewController.swift
//  Khari
//
//  Created by Evan Gruère on 10/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryViewController: UIViewController {
    
    let discoveryView = DiscoveryView()
    
    override func loadView() {
        self.view = discoveryView
    }
}
