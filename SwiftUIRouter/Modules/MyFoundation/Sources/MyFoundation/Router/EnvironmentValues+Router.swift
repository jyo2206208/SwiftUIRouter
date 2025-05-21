//
//  EnvironmentValues+Router.swift
//  MyFoundation
//
//  Created by 杜晔 on 2025/5/12.
//

import SwiftUI

extension EnvironmentValues {

    public var router: Router {
        get { self[RouterKey.self] }
        set { self[RouterKey.self] = newValue }
    }
}

private struct RouterKey: EnvironmentKey {

    nonisolated(unsafe) static let defaultValue: Router = Router(owner: .root())
}
