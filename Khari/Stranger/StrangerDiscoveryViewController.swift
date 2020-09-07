//
//  StrangerDiscoveryViewController.swift
//  Khari
//
//  Created by Evan Gruère on 01/08/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class StrangerDiscoveryViewController: DiscoveryViewController {
    
    let stranger: Stranger
    let strangerView = StrangerView()
    
    var chatViewController: ChatViewController?
    
    var topMargin = NSLayoutConstraint()
    
    init(with stranger: Stranger) {
        self.stranger = stranger
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.didChangeHeader = {
            self.topMargin.isActive = false
            self.topMargin = self.strangerView.topAnchor.constraint(equalTo: self.discoveryView.discoveryHeaderView!.bottomAnchor)
            self.topMargin.isActive = true
        }
        
        self.strangerView.translatesAutoresizingMaskIntoConstraints = false
        self.topMargin = self.strangerView.topAnchor.constraint(equalTo: self.view.topAnchor)
        self.view.addSubview(self.strangerView)
        NSLayoutConstraint.activate([
            self.strangerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.topMargin,
            self.strangerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.strangerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        self.strangerView.messageButton
            .addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMessageController)))
    }
    
    @objc func showMessageController(sender: UITapGestureRecognizer) {
        let chatViewController = ChatViewController(target: self.stranger.username)
        self.present(chatViewController, animated: true)
    }
}
