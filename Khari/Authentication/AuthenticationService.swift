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

enum ResponseError: Error {
    case malformedResponse
}

enum LoginError: Error {
    case responseError(error: ResponseError)
    case wrongCredentials
}

class AuthenticationService {

    static func register() -> AnyPublisher<String, Never> {
            return AF.request(ServerBaseUrl + "/auth/register")
                .publishResponse(using: JSONResponseSerializer())
                .subscribe(on: DispatchQueue.global())
                .compactMap { response in
                    guard let authentication = response.value as? Dictionary<String, Any>,
                        let token = authentication["token"] as? String else {
                            return nil
                    }
                    return token
            }.eraseToAnyPublisher()
    }
    
    static func login(with token: String) -> AnyPublisher<User, LoginError> {
        return AF.request(ServerBaseUrl + "/auth/login", headers: ["Authorization": "Bearer " + token])
            .publishResponse(using: JSONResponseSerializer())
            .tryMap { response in
                guard let authentication = response.value as? Dictionary<String, Any> else {
                    throw LoginError.responseError(error: ResponseError.malformedResponse)
                }
                var user: User
                do {
                    let data = try JSONSerialization.data(withJSONObject: authentication)
                    user = try JSONDecoder().decode(User.self, from: data)
                } catch { throw LoginError.responseError(error: ResponseError.malformedResponse) }
                return user
        }.mapError { error -> LoginError in return LoginError.wrongCredentials }
        .eraseToAnyPublisher()
    }
    
}
