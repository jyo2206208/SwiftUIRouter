//
//  BookRouter.swift
//  BookModule
//
//  Created by 杜晔 on 2025/5/6.
//

import SwiftUI
import MyFoundation

public struct BookTestRouterHandler: RouteHandler {

    public static var path: String { "test" }

    public static func view(for destination: MyFoundation.RouteDestination) -> any View {
        RouterTestView()
    }
}
