//
//  RouterTestView.swift
//  BookModule
//
//  Created by 杜晔 on 2025/5/6.
//

import SwiftUI
import MyFoundation

public struct RouterTestView: View {
    
    @Environment(\.router) var router
    
    public var body: some View {
        Button("push a new view") {
            router.navigate(to: "test", type: .push)
        }
        Button("sheet a new view") {
            router.navigate(to: "test", type: .sheet)
        }
        Button("fullScreenCover a new view") {
            router.navigate(to: "test", type: .fullScreenCover)
        }
        Button("goto home") {
            router.switchTab(to: 0)
        }
        Button("goto book") {
            router.switchTab(to: 1)
        }
        Button("goto trip") {
            router.switchTab(to: 2)
        }
        Button("goto me") {
            router.switchTab(to: 3)
        }
        Button("dismiss") {
            router.pop()
        }
        Button("dismissAll") {
            router.popToRoot()
        }
    }
    public init() {}
}

#Preview {
    RouterTestView()
}
