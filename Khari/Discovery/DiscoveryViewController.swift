//
//  DiscoveryViewController.swift
//  Khari
//
//  Created by Evan Gruère on 10/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryViewController: UIViewController {
    let discoveryView: DiscoveryView
    
    init(discoveryView: DiscoveryView) {
        self.discoveryView = discoveryView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = discoveryView
    }
}
