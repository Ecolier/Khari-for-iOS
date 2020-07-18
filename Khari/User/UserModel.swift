//
//  UserModel.swift
//  Khari
//
//  Created by Evan Gruère on 19/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import Foundation

struct User: Codable {
    var username: String
    var latitude: Double
    var longitude: Double
    var hiddenFrom: [String]
}
