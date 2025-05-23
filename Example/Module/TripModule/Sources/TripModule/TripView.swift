//
//  TripView.swift
//  TripModule
//
//  Created by 杜晔 on 2025/4/23.
//

import SwiftUI
import SwiftUIRouter

public struct TripView: View {

    @Environment(\.router) var router

    public var body: some View {
        Button("goto me") {
            router.switchTab(to: 3)
        }
    }
    public init() {}
}

#Preview {
    TripView()
}
