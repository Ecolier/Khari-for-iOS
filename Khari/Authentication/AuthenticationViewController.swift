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
    
    private var isLoggedIn = false
    private var registerCancellable: AnyCancellable!
    private var loginCancellable: AnyCancellable!
    
    override func loadView() {
        self.view = self.authenticationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
         
        if let token = AuthenticationRepository.fetchToken() {
            
            self.loginCancellable = AuthenticationService.login(with: token)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished: break
                    case .failure(_):
                        AuthenticationRepository.saveToken(nil)
                        return self.loginAnonymously()
                    }
                }, receiveValue: {
                    self.isLoggedIn = true
                    AuthenticationRepository.saveUser($0)
                    let homeViewController = HomeViewController()
                    homeViewController.modalPresentationStyle = .fullScreen
                    return self.present(homeViewController, animated: true)
                })
            
        } else {
            
            if self.isLoggedIn {
                return
            }
            
            self.registerCancellable = AuthenticationService.register().sink { token in
                AuthenticationRepository.saveToken(token)
                return self.loginAnonymously()
            }
            
        }
        
    }
    
    @objc func loginWithFacebook() {
        
    }
    
    @objc func loginWithGoogle() {
        
    }
}
