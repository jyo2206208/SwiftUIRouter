//
//  HotelListView.swift
//  HotelModule
//
//  Created by 杜晔 on 2025/4/24.
//

import SwiftUI
import MyService
import SwiftUIRouter

public struct HotelListView: View {
    
    @Environment(\.router) var router
    
    public var body: some View {
        ForEach(MyService.hotels) { hotel in
            HStack {
                Color.red.frame(width: 50, height: 50)
                Button(hotel.name) {
                    router.navigate(to: "hoteldetail",
                                    type: .sheet,
                                    param: ["hotelID": String(hotel.id)])
                }
            }
        }
    }
}

#Preview {
    HotelListView()
}

