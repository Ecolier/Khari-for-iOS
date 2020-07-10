//
//  StrangerController.swift
//  Khari
//
//  Created by Evan Gruère on 01/05/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class StrangerViewController: DiscoveryViewController {
    
    let stranger: Stranger
    
    init(_ stranger: Stranger) {
        self.stranger = stranger
        super.init(discoveryView: StrangerView())
        
        self.discoveryView.headerView.usernameLabel.text = self.stranger.username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
