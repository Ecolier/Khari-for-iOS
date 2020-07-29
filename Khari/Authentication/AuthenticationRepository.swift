//
//  AuthenticationRepository.swift
//  Khari
//
//  Created by Evan Gruère on 22/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import Foundation

class AuthenticationRepository {
    
    static func fetchUser() -> User? {
        var user: User? = nil
        guard let data = UserDefaults.standard.data(forKey: "user") else {
            return nil
        }
        
        do {
            user = try JSONDecoder().decode(User.self, from: data)
        } catch { print(error) }
        return user
    }
    
    static func saveUser(_ user: User) {
        do {
            let json = try JSONEncoder().encode(user)
            UserDefaults.standard.set(json, forKey: "user")
        } catch { print(error) }
    }
    
    static func fetchToken() -> String? {
        UserDefaults.standard.string(forKey: "token")
    }
    
    static func saveToken(_ token: String?) {
        UserDefaults.standard.set(token, forKey: "token")
    }
    
}
