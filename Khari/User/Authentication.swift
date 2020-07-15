//
//  Authentication.swift
//  Khari
//
//  Created by Evan Gruère on 01/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class Authentication {
    static func register() -> AnyPublisher<User, Never> {
        return Deferred {
            AF.request(ServerBaseUrl + "/auth/register")
                .publishResponse(using: JSONResponseSerializer())
                .compactMap { response in
                    guard let authentication = response.value as? Dictionary<String, Any>,
                        let username = authentication["username"] as? String,
                        let password = authentication["password"] as? String else {
                            return nil
                    }
                    let user = User(username: username,
                                       password: password)
                    return user
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
    
    static func login(username: String, password: String) -> AnyPublisher<User, Never> {
        return Deferred {
            AF.request(ServerBaseUrl + "/auth/login", method: .post, parameters:
                ["username": username, "password": password], encoder: JSONParameterEncoder()).publishResponse(using: JSONResponseSerializer())
                .compactMap { response in
                    guard let authentication = response.value as? Dictionary<String, Any>,
                        let username = authentication["username"] as? String,
                        let password = authentication["password"] as? String else {
                            return nil
                    }
                    let user = User(username: username,
                                       password: password)
                    return user
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
    
    static func fetchCurrentUser() -> User? {
        guard let currentUser = UserDefaults.standard.dictionary(forKey: "current user") else {
            return nil
        }
        
        return User(username: currentUser["username"] as! String,
                    password: currentUser["password"] as! String)
    }

    static func saveCurrentUser(_ user: User) {
        UserDefaults.standard.set([
            "username": user.username,
            "password": user.password
        ], forKey: "current user")
    }
}
