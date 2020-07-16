//
//  AuthenticationViewController.swift
//  Khari
//
//  Created by Evan Gruère on 16/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit
import Combine
import SocketIO

class AuthenticationViewController: UIViewController {
    
    let authenticationView = AuthenticationView()
    let homeViewController: HomeViewController
    
    private var loginCancellable: AnyCancellable!
    private let socketManager: SocketManager
    
    init(socketManager: SocketManager) {
        self.socketManager = socketManager
        self.homeViewController = HomeViewController(socket: socketManager.defaultSocket)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.authenticationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeViewController.modalPresentationStyle = .fullScreen
        
        self.authenticationView.titleLabel.text = "Khari"
        self.authenticationView.subtitleLabel.text = "Networking, human-sized"
        
        self.authenticationView.anonymousLoginButton.setTitle("Login anonymously", for: .normal)
        self.authenticationView.facebookLoginButton.setTitle("Login with Facebook", for: .normal)
        self.authenticationView.googleLoginButton.setTitle("Login with Google", for: .normal)
        
        self.authenticationView.anonymousLoginButton.addTarget(self, action: #selector(loginAnonymously),
                                                               for: .touchUpInside)
        self.authenticationView.facebookLoginButton.addTarget(self, action: #selector(loginWithFacebook),
                                                              for: .touchUpInside)
        self.authenticationView.googleLoginButton.addTarget(self, action: #selector(loginWithGoogle),
                                                            for: .touchUpInside)
    }
    
    @objc func loginAnonymously() {
        self.loginCancellable = AuthenticationService.login(username: "12345678", password: "ABCDEF12").sink { user in
            if self.socketManager.defaultSocket.status == .connected {
                self.homeViewController.user = user
                self.present(self.homeViewController, animated: true)
            }
        }
    }
    
    @objc func loginWithFacebook() {
        
    }
    
    @objc func loginWithGoogle() {
        
    }
}
