//
//  MessageInputView.swift
//  Khari
//
//  Created by Evan Gruère on 06/08/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class ComposeView: UITextView {
    
    let sendIcon = UIImageView(image: UIImage(systemName: "arrow.up.circle.fill"))
    
    init() {
        super.init(frame: .zero, textContainer: nil)
        
        self.addSubview(self.sendIcon)
        self.sendIcon.translatesAutoresizingMaskIntoConstraints = false
        self.textContainerInset = UIEdgeInsets(top: 15, left: 9, bottom: 12, right: 9)
        
        NSLayoutConstraint.activate([
            self.sendIcon.centerYAnchor.constraint(equalTo: self.frameLayoutGuide.centerYAnchor),
            self.sendIcon.trailingAnchor.constraint(equalTo: self.frameLayoutGuide.trailingAnchor, constant: -9),
            self.sendIcon.widthAnchor.constraint(equalToConstant: 36),
            self.sendIcon.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
