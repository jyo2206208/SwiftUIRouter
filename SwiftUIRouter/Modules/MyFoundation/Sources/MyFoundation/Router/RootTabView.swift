//
//  RootTabView.swift
//  MyFoundation
//
//  Created by 杜晔 on 2025/5/15.
//

import SwiftUI
import Combine

public struct RootTabView<Content: View> : View {

    @StateObject var applicationRouter: ApplicationRouter
    let content: Content

    public init(applicationRouter: ApplicationRouter, @ViewBuilder content: () -> Content) {
        _applicationRouter = .init(wrappedValue: applicationRouter)
        self.content = content()
    }

    public var body: some View {
        TabView(selection: $applicationRouter.selectedTab) {
            content
        }.environmentObject(applicationRouter)
        .onOpenURL {
            guard applicationRouter.selectedTab < applicationRouter.rootRouters.count else { return }
            let currentRootRouter = applicationRouter.rootRouters[applicationRouter.selectedTab]
            currentRootRouter.openURL(url: $0)
        }
    }
}
