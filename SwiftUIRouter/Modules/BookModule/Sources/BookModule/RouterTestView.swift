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
