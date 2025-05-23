//
//  ContentView.swift
//  HomeModule
//
//  Created by 杜晔 on 2025/4/23.
//

import SwiftUI
import SwiftUIRouter

struct HomeView: View {

    @Environment(\.router) var router
    @Environment(\.openURL) var openURL

    var body: some View {
        Button("goto hotel list") {
            router.navigate(to: "hotellist")
        }
        Button("goto test") {
            router.navigate(to: "test")
        }
        Button("Open URL: swiftuirouter://deeplink/test") {
            openURL(URL(string: "swiftuirouter://deeplink/test")!)
        }
        Button("Open URL: swiftuirouter://deeplink/hotellist") {
            openURL(URL(string: "swiftuirouter://deeplink/hotellist")!)
        }
        Button("Open URL: swiftuirouter://deeplink/hoteldetail?hotelID=3") {
            openURL(URL(string: "swiftuirouter://deeplink/hoteldetail?hotelID=3")!)
        }
        Button("Open URL: swiftuirouter://deeplink/me") {
            openURL(URL(string: "swiftuirouter://deeplink/me")!)
        }
        Button("goto me") {
            router.switchTab(to: 3)
        }
    }
}

#Preview {
    HomeView()
}
