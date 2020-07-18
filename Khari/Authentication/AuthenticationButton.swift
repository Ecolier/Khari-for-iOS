//
//  AuthenticationButton.swift
//  Khari
//
//  Created by Evan Gruère on 16/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class AuthenticationButton: UIButton {

    init() {
        super.init(frame: .zero)
        self.layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
