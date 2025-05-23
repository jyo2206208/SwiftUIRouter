//
//  ContentView.swift
//  SwiftUIRouterExample
//
//  Created by 杜晔 on 2025/5/21.
//

import SwiftUI
import MyService
import SwiftUIRouter

struct ContentView: View {

    @State private var selectedTab = 0

//    var body: some View {
//        HomeView().router(.init(owner: .root()))
//    }

//    var body: some View {
//        let routerTuples: [(RootTabs, Router)] = RootTabs.allCases.map {
//            ($0, Router(owner: .root($selectedTab)))
//        }
//        TabView(selection: $selectedTab) {
//            ForEach(routerTuples, id: \.0) { tab, router in
//                tab
//                    .router(router)
//                    .tabItem { Label(tab.title, systemImage: tab.image) }
//                    .tag(tab.rawValue)
//            }
//        }
//    }

    var body: some View {
        let routerTuples: [(RootTabs, Router)] = RootTabs.allCases.map {
            ($0, Router(owner: .root($selectedTab)))
        }
        TabView(selection: $selectedTab) {
            ForEach(routerTuples, id: \.0) { tab, router in
                Router
                    .rootView(for: tab.rawValue)
                    .router(router)
                    .tabItem { Label(tab.title, systemImage: tab.image) }
                    .tag(tab.rawValue)

            }
        }.onOpenURL { url in
            guard routerTuples.count > selectedTab else { return }
            let pathString = url.pathString
            let param = url.compactQueryParameters
            routerTuples[selectedTab].1.navigate(to: pathString, type: .push, param: param)
        }
    }
}

private extension URL {

    var pathString: String {
        if let first = pathComponents.first, first == "/" {
            return pathComponents.dropFirst().joined(separator: "/")
        }
        return pathComponents.joined(separator: "/")
    }

    var queryParameters: [String: String?] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return [:] }
        return components.queryParameters
    }

    var compactQueryParameters: [String: String] {
        queryParameters.compactMapValues({ $0 })
    }
}

private extension URLComponents {

    var queryParameters: [String: String?] {
        (queryItems ?? []).reduce(into: [String: String?](), { $0[$1.name] = $1.value })
    }
}
