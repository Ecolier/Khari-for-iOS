//
//  AppDelegate.swift
//  Khari
//
//  Created by Evan Gruère on 05/12/2019.
//  Copyright © 2019 Evan Gruère. All rights reserved.
//

import UIKit
import SocketIO

@UIApplicationMain
class ApplicationDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var socketManager: SocketManager = {
        return SocketManager(socketURL: URL(string: ServerBaseUrl)!)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
    
}
