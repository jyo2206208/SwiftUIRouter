# SwiftUIRouter

[![Support](https://img.shields.io/badge/support-iOS%2017%2B-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;

A lightweight SwiftUI routing framework using registration-based decoupling, supporting URL Schemes and Universal Links.


## Features

- **Decoupling**: Zero coupling between modules through registration mechanism
- **Native SwiftUI Support**: Designed specifically for SwiftUI
- **Multi-scenario Support**:
  - In-app routing
  - URL Scheme navigation
  - Universal Links handling
- **Navigation Control**:
  - Tab switching
  - View dismissal (single, all, or modal-only)

## Installation

### Swift Package Manager

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/jyo2206208/SwiftUIRouter.git", from: "x.x.x")
]
```

## Usage
1. Register Routers for your View

```swift
extension HotelListView: RouteHandler {

    public static var path: String { "hotellist" }

    public static func view(for destination: RouteDestination) -> HotelListView? {
        HotelListView()
    }
}

```
```swift
// Second, register it after launch
Router.register(handlers: [
    HotelListView.self
])
```

2. Add router ability

```swift
// add router ability for a rootView
var body: some View {
    HomeView().router(.init(owner: .root()))
}

```
```swift
// add router ability for a TabView based app
@State private var selectedTab = 0
var body: some View {
    let routerTuples: [(RootTabs, Router)] = RootTabs.allCases.map {
        ($0, Router(owner: .root($selectedTab)))
    }
    TabView(selection: $selectedTab) {
        ForEach(routerTuples, id: \.0) { tab, router in
            tab
                .router(router)
                .tabItem { Label(tab.title, systemImage: tab.image) }
                .tag(tab.rawValue)
        }
    }
}
```
```swift
var body: some View {
    let routerTuples: [(RootTabs, Router)] = RootTabs.allCases.map {
        ($0, Router(owner: .root($selectedTab)))
    }
    TabView(selection: $selectedTab) {
        ForEach(routerTuples, id: \.0) { tab, router in
            tab
                .router(router)
                .tabItem { Label(tab.title, systemImage: tab.image) }
                .tag(tab.rawValue)

        }
    }.onOpenURL {
        guard routerTuples.count > selectedTab else { return }
        routerTuples[selectedTab].1.openURL(url: $0)
    }
}
```


 * Navigation

```swift
public struct HomeView: View {
    
    @Environment(\.router) var router
    
    public var body: some View {
        Button("goto hotel list") {
            router.navigate(to: "hotellist")
        }
        Button("Open URL: swiftuirouter://deeplink/hotellist") {
            router.openURL(url: URL(string: "swiftuirouter://deeplink/hotellist")!)
        }
        Button("goto me") {
            router.switchTab(to: 3)
        }
    }
}
```

 * Dismiss

```swift
Button("dismiss") {
    router.dismiss()
}
Button("dismissAll") {
    router.dismissAll()
}
Button("dismissAllModal") {
    router.dismissAllModal()
}
```



### License

MIT.
