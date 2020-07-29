//
//  SocketManager.swift
//  Khari
//
//  Created by Evan Gruère on 21/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import Foundation
import SocketIO
import Combine

class SocketManager {
    
    private static let instance = SocketManager()
    private let manager = SocketIO.SocketManager(socketURL: URL(string: ServerBaseUrl)!)
    private lazy var socket = self.manager.defaultSocket
    
    private lazy var strangerLocationUpdatedSubject = PassthroughSubject<Stranger, Never>()
    private lazy var strangerDiscoveredSubject = PassthroughSubject<Stranger, Never>()
    
    lazy var onStrangerLocationUpdated = self.strangerLocationUpdatedSubject.eraseToAnyPublisher()
    lazy var onStrangerDiscovered = self.strangerDiscoveredSubject.eraseToAnyPublisher()
    
    private init() {
        self.socket.on("stranger location updated") { data, ack in
            if let stranger = data[0] as? [String: Any] {
                do {
                    let data = try JSONSerialization.data(withJSONObject: stranger)
                    let stranger = try JSONDecoder().decode(Stranger.self, from: data)
                    self.strangerLocationUpdatedSubject.send(stranger)
                } catch { print(error) }
            }
        }
        
        self.socket.on("connect") { data, ack in
            print("connected")
        }
        
        self.socket.on("strangers discovered") { data, ack in
            data.forEach {
                let data = try! JSONSerialization.data(withJSONObject: $0 as! [String: Any])
                let stranger = try! JSONDecoder().decode(Stranger.self, from: data)
                self.strangerDiscoveredSubject.send(stranger)
            }
        }
    }
    
    func updateUserLocation(token: String, longitude: Double, latitude: Double) {
        self.socket.emit("update location", ["token": token, "latitude": latitude, "longitude": longitude])
    }
    
    static func shared() -> SocketManager { return self.instance }
    func connect() { self.socket.connect() }
    func disconnect() { self.socket.disconnect() }
    
}
