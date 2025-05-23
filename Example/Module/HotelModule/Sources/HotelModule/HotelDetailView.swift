//
//  HotelDetailView.swift
//  HotelModule
//
//  Created by 杜晔 on 2025/4/24.
//

import SwiftUI
import MyService

struct HotelDetailView: View {

    private var hotelID: String
    
    var body: some View {
        if let hotel = hotels.filter { $0.id == Int(hotelID) }.first {
            VStack(spacing: 20) {
                Text("HotelID = \(hotel.id)").font(.headline)
                Text("HotelName = \(hotel.name)").font(.headline)
                Text("HotelAddress = \(hotel.address)").font(.headline)
                Text("HotelLevel = \(hotel.level) ⭐️").font(.headline)
            }
            .padding()
        }
    }
    
    init(hotelID: String) {
        self.hotelID = hotelID
    }
}

#Preview {
    HotelDetailView(hotelID: "2")
}
