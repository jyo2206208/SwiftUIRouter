//
//  BookModule.swift
//  BookModule
//
//  Created by 杜晔 on 2025/5/22.
//

import SwiftUIRouter

@MainActor
public struct BookModule {

    public init() {
        Router.register(handlers: [RouterTestView.self, BookView.self])
    }
}

extension RouterTestView: RouteHandler {

    static var path: String { "test" }

    static func view(for destination: RouteDestination) -> RouterTestView? {
        RouterTestView()
    }
}

extension BookView: RouteHandler {

    static var path: String { "book" }

    static func view(for destination: SwiftUIRouter.RouteDestination) -> BookView? {
        BookView()
    }

    static var tabIfRoot: Int? { 1 }
}
