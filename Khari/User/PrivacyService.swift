//
//  UserActions.swift
//  Khari
//
//  Created by Evan Gruère on 10/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit
import Alamofire
import Combine

class PrivacyService {
    
    static func setHiddenFrom(username: String,
                              password: String,
                              strangerUsername: String) {
        AF.request(ServerBaseUrl + "/user/privacy",
                   method: .post,
                   parameters: ["username": username, "password": password,
                                "mode": "hidden", "target": strangerUsername],
                   encoder: JSONParameterEncoder()).responseJSON { response in }
    }
    
    static func setVisibleTo(username: String,
                             password: String,
                             strangerUsername: String) {
        AF.request(ServerBaseUrl + "/user/privacy",
                   method: .post,
                   parameters: ["username": username, "password": password,
                                "mode": "visible", "target": strangerUsername],
                   encoder: JSONParameterEncoder()).responseJSON { response in }
    }
    
    static func isHiddenFrom(username: String,
                             password: String,
                             strangerUsername: String) -> AnyPublisher<Bool, Never> {
        AF.request(ServerBaseUrl + "/user/privacy",
                   parameters: ["username": username, "password": password,
                                "target": strangerUsername])
            .publishResponse(using: JSONResponseSerializer())
            .compactMap({ return $0.value as? Bool })
            .eraseToAnyPublisher()
    }
    
}
