//
//  MeView.swift
//  MeModule
//
//  Created by 杜晔 on 2025/4/23.
//

import SwiftUI
import SwiftUIRouter

struct MeView: View {

    @Environment(\.router) var router
    @Environment(\.openURL) var openURL

    var body: some View {
        Button("goto home") {
            router.switchTab(to: 0)
        }
        Button("Open URL: swiftuirouter://deeplink/home") {
            openURL(URL(string: "swiftuirouter://deeplink/home")!)
        }
    }
}

#Preview {
    MeView()
}
