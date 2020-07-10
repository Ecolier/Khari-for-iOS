//
//  StrangerModel.swift
//  Khari
//
//  Created by Evan Gruère on 24/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import Foundation

struct Stranger {
    var username: String = ""
    var longitude: Double = 0
    var latitude: Double = 0
    var distance: Double = 0
}

extension Stranger {
    init(from dict: [String: Any]) {
        self.username = dict["username"] as? String ?? ""
        self.longitude = dict["longitude"] as? Double ?? 0
        self.latitude = dict["latitude"] as? Double ?? 0
    }
}
