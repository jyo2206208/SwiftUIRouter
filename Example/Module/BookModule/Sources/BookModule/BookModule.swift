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
        Router.register(handlers: [RouterTestView.self])
    }
}
