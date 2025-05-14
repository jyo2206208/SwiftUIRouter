//
//  ContentView.swift
//  SwiftUIRouter
//
//  Created by 杜晔 on 2025/5/12.
//

import SwiftUI
import HomeModule
import BookModule
import TripModule
import MeModule
import MyFoundation
import MyService

struct RootTabView : View {

    @State var selectedTab: Int = 0

    @StateObject var applicationRouter = ApplicationRouter(rootCount: RootTabs.allCases.count)

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Array(zip(RootTabs.allCases, applicationRouter.rootRouters)), id: \.0) { tab, router in
                RouterView(router: .init(wrappedValue: router)) {
                    tab
                }.tabItem {
                    Label(tab.title, systemImage: tab.image)
                }.tag(tab.rawValue)
            }
        }.environmentObject(applicationRouter)
        .onOpenURL {
            guard selectedTab < applicationRouter.rootRouters.count else { return }
            let currentRootRouter = applicationRouter.rootRouters[selectedTab]
            currentRootRouter.openURL(url: $0)
        }
        .onReceive(applicationRouter.$selectedTab) {
            guard RootTabs.init(rawValue: $0) != nil else { return }
            selectedTab = $0
        }
    }
}
