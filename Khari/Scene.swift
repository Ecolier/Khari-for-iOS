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

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = HomeViewController()
            window.makeKeyAndVisible()
            self.window = window
        }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        if let delegate = UIApplication.shared.delegate as? ApplicationDelegate {
            delegate.socketManager.disconnect()
        }
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        if let delegate = UIApplication.shared.delegate as? ApplicationDelegate {
            delegate.socketManager.connect()
        }
    }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }

}

