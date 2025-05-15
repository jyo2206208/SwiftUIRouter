//
//  RootTabView.swift
//  MyFoundation
//
//  Created by 杜晔 on 2025/5/15.
//

import SwiftUI
import Combine

final class ApplicationRouter: ObservableObject {

    fileprivate let rootRouters: [Router]
    @Published var selectedTab: Int = 0

    fileprivate init(rootRouters: [Router]) {
        self.rootRouters = rootRouters
    }
}

public struct RootTabView<Content: View> : View {

    @StateObject var applicationRouter: ApplicationRouter
    let content: Content

    public init<T: CaseIterable>(tab: T.Type, @ViewBuilder content: (T.Type, [Router]) -> Content) {
        let rootRouters = tab.allCases.map {_ in Router(owner: .root) }
        _applicationRouter = .init(wrappedValue: .init(rootRouters: rootRouters))
        self.content = content(tab, rootRouters)
    }

    public var body: some View {
        TabView(selection: $applicationRouter.selectedTab) {
            content
        }
        .environmentObject(applicationRouter)
        .onOpenURL {
            guard applicationRouter.selectedTab < applicationRouter.rootRouters.count else { return }
            let currentRootRouter = applicationRouter.rootRouters[applicationRouter.selectedTab]
            currentRootRouter.openURL(url: $0)
        }
    }
}
