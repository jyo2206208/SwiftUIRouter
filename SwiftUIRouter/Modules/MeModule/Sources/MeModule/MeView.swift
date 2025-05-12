//
//  MeView.swift
//  MeModule
//
//  Created by 杜晔 on 2025/4/23.
//

import SwiftUI
import MyFoundation

public struct MeView: View {
    
    @Environment(\.router) var router
    
    public var body: some View {
        Button("Button to test") {
            router.navigate(to: "test", type: .sheet)
        }
    }
    
    public init() {}
}

#Preview {
    MeView()
}
