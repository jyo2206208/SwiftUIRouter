//
//  MeModule.swift
//  MeModule
//
//  Created by Ethan.Du on 2025/5/23.
//

import SwiftUIRouter

@MainActor
public struct MeModule {

    public init() {
        Router.register(handlers: [MeView.self])
    }
}

extension MeView: RouteHandler {

    static var path: String { "me" }

    static func view(for destination: RouteDestination) -> MeView? {
        MeView()
    }

    static var tabIfRoot: Int? { 3 }
}
