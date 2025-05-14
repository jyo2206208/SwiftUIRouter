//
//  RootTabView.swift
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

    @StateObject var applicationRouter = ApplicationRouter(rootCount: RootTabs.allCases.count)

    var body: some View {
        TabView(selection: $applicationRouter.selectedTab) {
            ForEach(Array(zip(RootTabs.allCases, applicationRouter.rootRouters)), id: \.0) { tab, router in
                RouterView(router: .init(wrappedValue: router)) {
                    tab
                }.tabItem {
                    Label(tab.title, systemImage: tab.image)
                }.tag(tab.rawValue)
            }
        }.environmentObject(applicationRouter)
        .onOpenURL {
            guard applicationRouter.selectedTab < applicationRouter.rootRouters.count else { return }
            let currentRootRouter = applicationRouter.rootRouters[applicationRouter.selectedTab]
            currentRootRouter.openURL(url: $0)
        }
    }
}
