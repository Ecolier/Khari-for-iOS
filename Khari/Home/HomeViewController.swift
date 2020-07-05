//
//  Main.swift
//  Khari
//
//  Created by Evan Gruère on 17/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit
import Combine

class HomeViewController: CoverableViewController {
    
    private var userLocationDidUpdateCancellable: AnyCancellable!
    private var loginCancellable: AnyCancellable!
    
    let mapViewController: MapViewController
    let discoveryViewController: DiscoveryViewController
    var user: User!
    
    init() {
        
        self.mapViewController = MapViewController()
        self.discoveryViewController = DiscoveryViewController()
        
        super.init(nibName: nil, bundle: nil)
        
        if let storedUser = Authentication.fetchCurrentUser() {
            self.loginCancellable = Authentication.login(username: storedUser.username, password: storedUser.password).sink { user in
                self.user = user
            }
        }
        
        self.fullscreenViewController = self.mapViewController
        self.collapsableViewController = self.discoveryViewController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userController = UserController()
        userController.managedUser = self.user
        self.discoveryViewController.managedViewController = userController
        
        self.mapViewController.onUserAnnotationSelected = {
            let userController = UserController()
            userController.managedUser = self.user
            self.discoveryViewController.managedViewController = userController
        }
        
        self.mapViewController.onStrangerAnnotationSelected = { stranger in
            let strangerController = StrangerController()
            strangerController.managedStranger = stranger
            self.discoveryViewController.managedViewController = strangerController
        }
        
        self.userLocationDidUpdateCancellable = self.mapViewController.userLocationDidUpdate.sink { coordinate in
            
            if let delegate = UIApplication.shared.delegate as? ApplicationDelegate {
                delegate.socketManager.defaultSocket.emit("update user location", [
                    ["username": self.user.username]
                ])
            }
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let userView = self.discoveryViewController.managedViewController.view as? UserView {
            let userHeader = userView.userHeader
            self.discoveryViewController.discoveryView.collapsedY = self.view.bounds.height - userHeader.frame.height
            self.discoveryViewController.discoveryView.fullY = self.view.safeAreaInsets.top
            self.discoveryViewController.discoveryView.breakY = self.view.bounds.height / 2
            self.discoveryViewController.discoveryView.frame = CGRect(
                x: 0, y: self.view.bounds.height - userHeader.frame.height,
                width: self.view.bounds.width, height: self.view.bounds.height - self.view.safeAreaInsets.top)
        }
        
    }
    
}
