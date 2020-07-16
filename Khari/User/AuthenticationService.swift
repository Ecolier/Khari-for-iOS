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
    static func register() -> AnyPublisher<User, Never> {
        return Deferred {
            AF.request(ServerBaseUrl + "/auth/register")
                .publishResponse(using: JSONResponseSerializer())
                .compactMap { response in
                    guard let authentication = response.value as? Dictionary<String, Any> else {
                        return nil
                    }
                    let data = try! JSONSerialization.data(withJSONObject: authentication)
                    return try! JSONDecoder().decode(User.self, from: data)
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
    
    static func login(username: String, password: String) -> AnyPublisher<User, Never> {
        return AF.request(ServerBaseUrl + "/auth/login", method: .post, parameters:
            ["username": username, "password": password], encoder: JSONParameterEncoder())
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
}
