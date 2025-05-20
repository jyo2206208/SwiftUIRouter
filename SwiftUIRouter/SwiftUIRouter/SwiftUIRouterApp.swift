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
import HomeModule
import TripModule
import MeModule
import MyService

@main
struct SwiftUIRouterApp: App {
    
    init() {
        Router.register(handlers: [
            HotelListView.self,
            HotelDetailView.self,
            RouterTestView.self
        ])
    }

    var body: some Scene {
        WindowGroup {
            HomeView().router(.init(owner: .root))
        }
    }

//    var body: some Scene {
//        WindowGroup {
//            RootTabView(tab: RootTabs.self) { tab, routers in
//                ForEach(Array(zip(tab.allCases, routers)), id: \.0) { tab, router in
//                    tab
//                        .router(router)
//                        .tabItem { Label(tab.title, systemImage: tab.image) }
//                        .tag(tab.rawValue)
//                }
//            }
//        }
//    }
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
