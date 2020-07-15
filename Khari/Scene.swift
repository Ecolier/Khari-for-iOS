//
//  SceneDelegate.swift
//  Khari
//
//  Created by Evan Gruère on 05/12/2019.
//  Copyright © 2019 Evan Gruère. All rights reserved.
//

import UIKit
import SwiftUI
import Combine
import SocketIO

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    lazy var socketManager: SocketManager = {
        return SocketManager(socketURL: URL(string: ServerBaseUrl)!)
    }()
    
    private var loginCancellable: AnyCancellable!
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            window.rootViewController = LaunchViewController()
            
            self.loginCancellable = Authentication.login(username: "12345678", password: "ABCDEF12").sink { user in
                
                self.socketManager.defaultSocket.on(clientEvent: .connect) { data, ack in
                    window.rootViewController = HomeViewController(user: user, socket: self.socketManager.defaultSocket)
                }
                
            }
            
            window.makeKeyAndVisible()
            self.window = window
        }
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        self.socketManager.defaultSocket.disconnect()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        self.socketManager.defaultSocket.connect()
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
    
}

