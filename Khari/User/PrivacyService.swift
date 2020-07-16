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
    
    static func setHiddenFrom(username: String, token: String, strangerUsername: String) {
        AF.request(ServerBaseUrl + "/user/" + username + "/privacy/mode",
                   method: .post,
                   parameters: ["mode": "hidden", "target": strangerUsername],
                   encoder: JSONParameterEncoder()).responseJSON { response in }
    }
    
    static func setVisibleTo(username: String, token: String, strangerUsername: String) {
        AF.request(ServerBaseUrl + "/user/" + username + "/privacy/mode",
                   method: .post,
                   parameters: ["mode": "visible", "target": strangerUsername],
                   encoder: JSONParameterEncoder()).responseJSON { response in }
    }
    
    static func isHiddenFrom(username: String, token: String, strangerUsername: String) -> AnyPublisher<Bool, Never> {
        AF.request(ServerBaseUrl + "/user/" + username + "/privacy/mode",
                   parameters: ["target": strangerUsername])
            .publishResponse(using: JSONResponseSerializer())
            .compactMap({ return $0.value as? Bool })
            .eraseToAnyPublisher()
    }
    
}
