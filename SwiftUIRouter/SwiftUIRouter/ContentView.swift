//
//  ContentView.swift
//  SwiftUIRouter
//
//  Created by 杜晔 on 2025/5/12.
//

import SwiftUI
import HomeModule
import BookModule
import TripModule
import MeModule
import MyFoundation
import MyService

struct RootTabView : View {
    
    @SceneStorage("selectedTab") var selectedTab: RootTabs = .home
    @Environment(\.router) var router

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(RootTabs.allCases) { tab in
                RouterView(parentRouter: router, owner: .root) {
                    tab
                }.tabItem {
                    Label(tab.title, systemImage: tab.image)
                }.tag(tab)
            }
        }
    }
}

enum RootTabs: Int, Codable, CaseIterable {
    
    case home
    case book
    case trip
    case me
}

extension RootTabs: Identifiable {
    
    var id: String {
        "\(self)"
    }
    
    var title: String {
        switch self {
        case .home: "首页"
        case .book: "预定"
        case .trip: "行程"
        case .me: "账户"
        }
    }
    
    var image: String {
        switch self {
        case .home: "house"
        case .book: "tray.2"
        case .trip: "bag"
        case .me: "person"
        }
    }
}

extension RootTabs: View {
    
    var body: some View {
        switch self {
        case .home: HomeView()
        case .book: BookView()
        case .trip: TripView()
        case .me: MeView()
        }
    }
}
