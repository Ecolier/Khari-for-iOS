//
//  Geography.swift
//  Khari
//
//  Created by Evan Gruère on 24/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import CoreLocation

class Geography {
    static func bounds(for location: CLLocationCoordinate2D, in distance: Double) -> (minLat: Double, minLng: Double, maxLat: Double, maxLng: Double) {
        let earthRadius: Double = 6371
        let minLat: Double = location.latitude  - (distance / earthRadius) * (180 / Double.pi)
        let minLng: Double = location.longitude - (distance / earthRadius) * (180 / Double.pi) / cos(location.latitude * Double.pi/180)
        let maxLat: Double = location.latitude  + (distance / earthRadius) * (180 / Double.pi)
        let maxLng: Double = location.longitude + (distance / earthRadius) * (180 / Double.pi) / cos(location.latitude * Double.pi/180)
        return (minLat: minLat, minLng: minLng, maxLat: maxLat, maxLng: maxLng)
    }

    static func distance(between firstLocation: CLLocationCoordinate2D, and secondLocation: CLLocationCoordinate2D) -> Double {
        let r = 6371e3
        let t1 = firstLocation.latitude * Double.pi / 180
        let t2 = secondLocation.latitude * Double.pi / 180
        let dt = (secondLocation.latitude - firstLocation.latitude) * Double.pi / 180
        let dl = (secondLocation.longitude - firstLocation.longitude) * Double.pi / 180

        let a = sin(dt / 2) * sin(dt / 2) + cos(t1) * cos(t2) * sin(dl / 2) * sin(dl / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))

        let d = r * c
        return d
    }
}
