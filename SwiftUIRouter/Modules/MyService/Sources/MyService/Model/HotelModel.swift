//
//  HotelModel.swift
//  MyService
//
//  Created by 杜晔 on 2025/4/24.
//

import Foundation

public struct HotelModel: Identifiable, Sendable {
    
    public let id: Int
    public let name: String
    public let address: String
    public let level: Int
    
    public init(id: Int, name: String, address: String, level: Int) {
        self.id = id
        self.name = name
        self.address = address
        self.level = level
    }
}

public let hotels = [
    HotelModel(id: 0, name: "Hotel_1", address: "Shang Hai", level: 5),
    HotelModel(id: 1, name: "Hotel_2", address: "New York", level: 5),
    HotelModel(id: 2, name: "Hotel_3", address: "London", level: 4),
    HotelModel(id: 3, name: "Hotel_4", address: "Tokyo", level: 3),
    HotelModel(id: 4, name: "Hotel_5", address: "Mumbai", level: 5)
]
