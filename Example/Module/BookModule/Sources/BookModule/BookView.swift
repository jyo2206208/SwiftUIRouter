//
//  BookView.swift
//  BookModule
//
//  Created by 杜晔 on 2025/4/23.
//

import SwiftUI
import SwiftUIRouter

struct BookView: View {

    @Environment(\.router) var navigator: Router

    var body: some View {
        Button("sheet a new view") {
            navigator.navigate(to: "test", type: .push)
        }
    }
}

#Preview {
    BookView()
}
