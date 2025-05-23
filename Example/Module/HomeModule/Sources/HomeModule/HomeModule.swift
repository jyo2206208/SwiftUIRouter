//
//  HomeModule.swift
//  HomeModule
//
//  Created by Ethan.Du on 2025/5/23.
//

import SwiftUIRouter

@MainActor
public struct HomeModule {

    public init() {
        Router.register(handlers: [HomeView.self])
    }
}

extension HomeView: RouteHandler {

    static var path: String { "home" }

    static func view(for destination: SwiftUIRouter.RouteDestination) -> HomeView? {
        HomeView()
    }

    static var tabIfRoot: Int? { 0 }
}
