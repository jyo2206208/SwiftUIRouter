# SwiftUIRouter

[![Support](https://img.shields.io/badge/support-iOS%2017%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;

A lightweight SwiftUI routing framework using registration-based decoupling, supporting URL Schemes and Universal Links.

## Features

- **Decoupling**: Zero coupling between modules through registration mechanism
- **Native SwiftUI Support**: Designed specifically for SwiftUI
- **Multi-scenario Support**:
  - In-app routing
  - URL Scheme navigation
  - Universal Links handling

## Installation

### Swift Package Manager

Add to your Package.swift:
```swift
dependencies: [
    .package(url: "xxx.git", from: "1.0.0")
]
```

## Usage
1. Register Routes

```swift
// At First Implement RouteHandler protocol for your target View
public struct HotelListRouterHandler: RouteHandler {

    public static var path: String { "hotellist" }

    public static func view(for destination: RouteDestination) -> any View {
        HotelListView()
    }
}
```
```swift
// Sencond, register it after launch
Router.register(handlers: [
    HotelListRouterHandler.self
])
```

2. Navigation

```
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
    
    public init() {}
}
```

3. Dismiss

```
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
