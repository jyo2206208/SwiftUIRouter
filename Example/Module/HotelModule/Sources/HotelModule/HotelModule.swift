//
//  HotelModule.swift
//  HotelModule
//
//  Created by 杜晔 on 2025/5/22.
//

import SwiftUIRouter

@MainActor
public struct HotelModule {

    public init() {
        Router.register(handlers: [HotelListView.self, HotelDetailView.self])
    }
}
