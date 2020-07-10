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

class UserService {
    
    static func hideFromStranger(username: String,
                                 password: String,
                                 strangerUsername: String) {
        AF.request(ServerBaseUrl + "/user/privacy",
                   method: .post,
                   parameters: ["username": username, "password": password, "mode": "hidden", "target": strangerUsername],
                   encoder: JSONParameterEncoder()).responseJSON { response in
                    
        }
    }
    
    static func isHiddenFromStranger(username: String,
                                     password: String,
                                     strangerUsername: String) -> AnyPublisher<Bool, Never> {
        AF.request(ServerBaseUrl + "/user/visibility", parameters: ["target": strangerUsername])
            .publishResponse(using: JSONResponseSerializer())
            .compactMap({ return $0.value as? Bool })
            .eraseToAnyPublisher()
    }
    
}
