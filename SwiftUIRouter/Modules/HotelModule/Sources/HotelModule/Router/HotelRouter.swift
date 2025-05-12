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
    
    public var path: String { "hotellist" }
    
    public func view(for destination: RouteDestination) -> AnyView {
        AnyView(HotelListView())
    }
    
    public init() {}
}

public struct HotelDetailRouterHandler: RouteHandler {
    
    public var path: String { "hoteldetail" }
    
    public func view(for destination: RouteDestination) -> AnyView {
        guard let hotelID = destination.params?["hotelID"] as? String else { return AnyView(EmptyView()) }
        return AnyView(HotelDetailView(hotelID: hotelID))
    }
    
    public init() {}
}
