//
//  TripModule.swift
//  TripModule
//
//  Created by Ethan.Du on 2025/5/23.
//

import SwiftUIRouter

@MainActor
public struct TripModule {

    public init() {
        Router.register(handlers: [TripView.self])
    }
}

extension TripView: RouteHandler {

    static var path: String { "trip" }

    static func view(for destination: RouteDestination) -> TripView? {
        TripView()
    }

    static var tabIfRoot: Int? { 2 }
}
