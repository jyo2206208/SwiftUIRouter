//
//  HotelModule.swift
//  HomeRouter
//
//  Created by 杜晔 on 2025/4/23.
//

import SwiftUI
import MyFoundation
import Combine
import MyService

public struct HotelListRouterHandler: RouteHandler {

    public static var path: String { "hotellist" }

    public static func view(for destination: MyFoundation.RouteDestination) -> any View {
        HotelListView()
    }
}

public struct HotelDetailRouterHandler: RouteHandler {
    
    public static var path: String { "hoteldetail" }

    public static func view(for destination: MyFoundation.RouteDestination) -> any View {
        guard let hotelID = destination.params?["hotelID"] as? String else { return AnyView(EmptyView()) }
        return HotelDetailView(hotelID: hotelID)
    }
}
