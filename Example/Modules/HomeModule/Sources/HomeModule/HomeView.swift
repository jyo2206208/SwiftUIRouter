//
//  ContentView.swift
//  HomeModule
//
//  Created by 杜晔 on 2025/4/23.
//

import SwiftUI
import SwiftUIRouter

public struct HomeView: View {
    
    @Environment(\.router) var router

    public var body: some View {
        Button("goto hotel list") {
            router.navigate(to: "hotellist")
        }
        Button("goto test") {
            router.navigate(to: "test")
        }
        Button("Open URL: swiftuirouter://deeplink/test") {
            router.openURL(url: URL(string: "swiftuirouter://deeplink/test")!)
        }
        Button("Open URL: swiftuirouter://deeplink/hotellist") {
            router.openURL(url: URL(string: "swiftuirouter://deeplink/hotellist")!)
        }
        Button("Open URL: swiftuirouter://deeplink/hoteldetail?hotelID=3") {
            router.openURL(url: URL(string: "swiftuirouter://deeplink/hoteldetail?hotelID=3")!)
        }
        Button("goto me") {
            router.switchTab(to: 3)
        }
    }
    
    public init() {}
}

#Preview {
    HomeView()
}
