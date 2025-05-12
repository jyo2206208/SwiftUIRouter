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

// TODO: check preconcurrency
@MainActor
private struct RouterKey: @preconcurrency EnvironmentKey {
    
    static var defaultValue: Router = Router()
}
