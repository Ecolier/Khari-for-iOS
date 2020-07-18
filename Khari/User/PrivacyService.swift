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
    
    static func setHiddenFrom(token: String, strangerUsername: String) {
        AF.request(ServerBaseUrl + "/user/privacy/mode",
                   method: .post, parameters: ["mode": "hidden", "target": strangerUsername],
                   encoder: JSONParameterEncoder(),
                   headers: ["Authorization": "Bearer " + token]).responseJSON { response in }
    }
    
    static func setVisibleTo(token: String, strangerUsername: String) {
        AF.request(ServerBaseUrl + "/user/privacy/mode",
                   method: .post, parameters: ["mode": "visible", "target": strangerUsername],
                   encoder: JSONParameterEncoder(),
                   headers: ["Authorization": "Bearer " + token]).responseJSON { response in }
    }
    
    static func isHiddenFrom(token: String, strangerUsername: String) -> AnyPublisher<Bool, Never> {
        AF.request(ServerBaseUrl + "/user/privacy/mode",
                   parameters: ["target": strangerUsername],
                   headers: ["Authorization": "Bearer " + token])
            .publishResponse(using: JSONResponseSerializer())
            .compactMap({ return $0.value as? Bool })
            .eraseToAnyPublisher()
    }
    
}
