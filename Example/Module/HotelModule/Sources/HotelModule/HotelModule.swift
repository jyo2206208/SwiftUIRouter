//
//  HotelModule.swift
//  HotelModule
//
//  Created by 杜晔 on 2025/5/22.
//

import SwiftUI
import SwiftUIRouter

@MainActor
public struct HotelModule {

    public init() {
        Router.register(handlers: [HotelListView.self, HotelDetailView.self])
    }
}

extension HotelListView: RouteHandler {

    static var path: String { "hotellist" }

    static func view(for destination: RouteDestination) -> HotelListView? {
        HotelListView()
    }
}

extension HotelDetailView: RouteHandler {

    static var path: String { "hoteldetail" }

    static func view(for destination: RouteDestination) -> HotelDetailView? {
        guard let param = destination.param as? [String: String],
              let hotelID = param["hotelID"] else { return nil }
        return HotelDetailView(hotelID: hotelID)
    }
}
