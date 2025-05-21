//
//  ContentView.swift
//  SwiftUIRouter
//
//  Created by 杜晔 on 2025/5/21.
//

import SwiftUI
import MyFoundation
import MyService
import HotelModule
import BookModule
import HomeModule
import TripModule
import MeModule

struct ContentView: View {

    @State private var selectedTab = 0

//    var body: some View {
//        HomeView().router(.init(owner: .root()))
//    }

//    var body: some View {
//        let routerTuples: [(RootTabs, Router)] = RootTabs.allCases.map {
//            ($0, Router(owner: .root($selectedTab)))
//        }
//        TabView(selection: $selectedTab) {
//            ForEach(routerTuples, id: \.0) { tab, router in
//                tab
//                    .router(router)
//                    .tabItem { Label(tab.title, systemImage: tab.image) }
//                    .tag(tab.rawValue)
//            }
//        }
//    }

    var body: some View {
        let routerTuples: [(RootTabs, Router)] = RootTabs.allCases.map {
            ($0, Router(owner: .root($selectedTab)))
        }
        TabView(selection: $selectedTab) {
            ForEach(routerTuples, id: \.0) { tab, router in
                tab
                    .router(router)
                    .tabItem { Label(tab.title, systemImage: tab.image) }
                    .tag(tab.rawValue)

            }
        }.onOpenURL {
            guard routerTuples.count > selectedTab else { return }
            routerTuples[selectedTab].1.openURL(url: $0)
        }
    }
}
