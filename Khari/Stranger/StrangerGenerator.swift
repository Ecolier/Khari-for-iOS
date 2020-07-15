//
//  MockData.swift
//  Khari
//
//  Created by Evan Gruère on 29/04/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import Foundation
import CoreLocation

extension Stranger {
    
    static func random(around location: CLLocationCoordinate2D, for distance: Double) -> Stranger {
        var randomBytes = [UInt8](repeating: 0, count: 4)
        SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        let boundaries = Geography.bounds(for: location, in: distance)
        let longitude = Double.random(in: boundaries.minLng...boundaries.maxLng)
        let latitude = Double.random(in: boundaries.minLat...boundaries.maxLat)
        return Stranger(username: randomBytes.reduce("", { $0 + String(format: "%02x", $1) }),
                        longitude: longitude, latitude: latitude)
    }
        
}
