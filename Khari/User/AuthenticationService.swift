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

class AuthenticationService {
    static func register() -> AnyPublisher<String, Never> {
        return Deferred {
            AF.request(ServerBaseUrl + "/auth/register")
                .publishResponse(using: JSONResponseSerializer())
                .compactMap { response in
                    guard let authentication = response.value as? Dictionary<String, Any>,
                        let token = authentication["token"] as? String else {
                            return nil
                    }
                    return token
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
    
    static func login(token: String) -> AnyPublisher<User, Never> {
        return AF.request(ServerBaseUrl + "/auth/login", headers: ["Authorization": "Bearer " + token])
            .publishResponse(using: JSONResponseSerializer())
            .compactMap { response in
                var user: User? = nil
                guard let authentication = response.value as? Dictionary<String, Any> else {
                    return nil
                }
                do {
                    let data = try JSONSerialization.data(withJSONObject: authentication)
                    user = try JSONDecoder().decode(User.self, from: data)
                } catch {
                    print(error)
                }
                return user
        }.eraseToAnyPublisher()
    }
    
    static func fetchCurrentUser() -> User? {
        guard let currentUser = UserDefaults.standard.dictionary(forKey: "current user") else {
            return nil
        }
        let data = try! JSONSerialization.data(withJSONObject: currentUser)
        return try! JSONDecoder().decode(User.self, from: data)
    }
    
    static func saveCurrentUser(_ user: User) {
        UserDefaults.standard.set(user, forKey: "current user")
    }
    
    static func fetchToken() -> String? {
        UserDefaults.standard.string(forKey: "token")
    }
    
    static func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }
}
