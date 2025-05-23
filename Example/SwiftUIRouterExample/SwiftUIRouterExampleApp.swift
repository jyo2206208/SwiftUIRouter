//
//  SwiftUIRouterExampleApp.swift
//  SwiftUIRouterExample
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
        _ = HomeModule()
        _ = BookModule()
        _ = HotelModule()
        _ = TripModule()
        _ = MeModule()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

enum RootTabs: Int, Codable, CaseIterable, Identifiable {

    public var id: String { "\(self)" }

    case home
    case book
    case trip
    case me
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
