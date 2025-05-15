//
//  BookRouter.swift
//  BookModule
//
//  Created by 杜晔 on 2025/5/6.
//

import SwiftUI
import MyFoundation

extension RouterTestView: RouteHandler {

    public static var path: String { "test" }

    public static func view(for destination: RouteDestination) -> RouterTestView? {
        RouterTestView()
    }
}
