//
//  BookRouter.swift
//  BookModule
//
//  Created by 杜晔 on 2025/5/6.
//

import SwiftUI
import MyFoundation

public struct BookTestRouterHandler: RouteHandler {

    public var path: String { "test" }

    public func view(for destination: RouteDestination) -> AnyView {
        AnyView(RouterTestView())
    }

    public init() {}
}
