//
//  HotelModule.swift
//  HomeRouter
//
//  Created by 杜晔 on 2025/4/23.
//

import SwiftUI
import MyFoundation

extension HotelListView: RouteHandler {

    public static var path: String { "hotellist" }

    public static func view(for destination: MyFoundation.RouteDestination) -> HotelListView? {
        HotelListView()
    }
}

extension HotelDetailView: RouteHandler {

    public static var path: String { "hoteldetail" }

    public static func view(for destination: RouteDestination) -> HotelDetailView? {
        guard let param = destination.param as? [String: String],
              let hotelID = param["hotelID"] else { return nil }
        return HotelDetailView(hotelID: hotelID)
    }
}
