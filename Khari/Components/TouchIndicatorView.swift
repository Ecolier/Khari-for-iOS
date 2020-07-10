//
//  DragIndicatorView.swift
//  Khari
//
//  Created by Evan Gruère on 07/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class TouchIndicatorView: UIView {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 20, height: 6))
        self.backgroundColor = UIColor.systemGray3
        self.layer.cornerRadius = 3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
