//
//  SwiftUIRouterApp.swift
//  SwiftUIRouter
//
//  Created by 杜晔 on 2025/5/12.
//

import SwiftUI
import MyFoundation
import HotelModule
import BookModule

@main
struct SwiftUIRouterApp: App {
    
    init() {
        Router.register(handlers: [
            HotelListRouterHandler.self,
            HotelDetailRouterHandler.self,
            BookTestRouterHandler.self
        ])
    }
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
        }
    }
}
