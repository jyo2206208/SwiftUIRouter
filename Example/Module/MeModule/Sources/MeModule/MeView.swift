//
//  MeView.swift
//  MeModule
//
//  Created by 杜晔 on 2025/4/23.
//

import SwiftUI
import SwiftUIRouter

public struct MeView: View {
    
    @Environment(\.router) var router

    public var body: some View {
        Button("goto home") {
            router.switchTab(to: 0)
        }
    }
    
    public init() {}
}

#Preview {
    MeView()
}
