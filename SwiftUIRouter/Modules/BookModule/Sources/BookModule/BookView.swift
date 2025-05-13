//
//  BookView.swift
//  BookModule
//
//  Created by 杜晔 on 2025/4/23.
//

import SwiftUI
import MyFoundation

public struct BookView: View {

    @Environment(\.router) var navigator: Router

    public var body: some View {
        Button("sheet a new view") {
            navigator.navigate(to: "test", type: .push)
        }
    }
    public init() {}
}

#Preview {
    BookView()
}
