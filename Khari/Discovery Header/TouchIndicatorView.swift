//
//  DragIndicatorView.swift
//  Khari
//
//  Created by Evan Gruère on 07/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class TouchIndicatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.systemGray3
        self.layer.cornerRadius = 3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
