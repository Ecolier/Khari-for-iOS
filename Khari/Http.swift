//
//  Network.swift
//  Khari
//
//  Created by Evan Gruère on 04/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import Alamofire
import Combine

let KHRServerBaseUrl = "http://172.20.10.2:5000"

func KHRRequestCreateUser() -> AnyPublisher<KHRUser, Never> {
    return Deferred {
        AF.request(KHRServerBaseUrl + "/user/register")
            .publishResponse(using: DecodableResponseSerializer<KHRUser>())
            .map { $0.value! }
            .eraseToAnyPublisher()
    }.eraseToAnyPublisher()
}
