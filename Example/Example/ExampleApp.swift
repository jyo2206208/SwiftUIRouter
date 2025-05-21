//
//  ExampleApp.swift
//  Example
//
//  Created by 杜晔 on 2025/5/21.
//

import SwiftUI
import HotelModule
import BookModule
import HomeModule
import TripModule
import MeModule
import MyService
import SwiftUIRouter

@main
struct ExampleApp: App {

    init() {
        Router.register(handlers: [
            HotelListView.self,
            HotelDetailView.self,
            RouterTestView.self
        ])
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension RootTabs {

    var title: String {
        switch self {
        case .home: "首页"
        case .book: "预定"
        case .trip: "行程"
        case .me: "账户"
        }
    }

    var image: String {
        switch self {
        case .home: "house"
        case .book: "tray.2"
        case .trip: "bag"
        case .me: "person"
        }
    }
}

extension RootTabs: @retroactive View {

    public var body: some View {
        switch self {
        case .home: HomeView()
        case .book: BookView()
        case .trip: TripView()
        case .me: MeView()
        }
    }
}
