//
//  Router.swift
//  MyFoundation
//
//  Created by 杜晔 on 2025/4/24.
//

import Foundation
import SwiftUI
import Combine

@MainActor
public final class Router: ObservableObject {
    
    fileprivate static var routeHandlers: [String: RouteHandler] = [:]
    
    public static func register(handlers: [RouteHandler]) {
        handlers.forEach {
            routeHandlers[$0.path] = $0
        }
    }
    
    private let parent: Router?
    
    init(parent: Router? = nil) {
        self.parent = parent
    }
    
    // TODO: resolve AnyView
    static func view(for destination: RouteDestination) -> AnyView? {
        if let handler = Router.routeHandlers[destination.path] {
            return handler.view(for: destination)
        }
        
        for (path, handler) in Router.routeHandlers {
            if destination.path.hasPrefix(path) {
                return handler.view(for: destination)
            }
        }
        
        return nil
    }
    
    @Published var navigationPath = NavigationPath()
    @Published var presentedSheetDestination: RouteDestination?
    @Published var presentedFullScreenCoverDestination: RouteDestination?
    @Published var dismissPresentedView: Bool?
    
    public func navigate(to path: String,
                         type: NavigationType = .push,
                         params: [String: Any]? = nil) {
        let destination = RouteDestination(path: path, params: params)
        switch type {
        case .push:
            navigationPath.append(destination)
        case .sheet:
            presentedSheetDestination = destination
        case .fullScreenCover:
            presentedFullScreenCoverDestination = destination
        }
    }
    
    public func openURL(url: URL) {
        let pathString = url.pathString
        let params = url.compactQueryParameters
        navigate(to: pathString, type: .push, params: params)
    }
    
    public func pop() {
        if navigationPath.isEmpty {
            dismissPresentedView = true
        } else {
            navigationPath.removeLast()
        }
    }
    
    public func popToRoot() {
        if let parent = parent {
            parent.popToRoot()
        } else {
            navigationPath.removeLast(navigationPath.count)
            presentedSheetDestination = nil
            presentedFullScreenCoverDestination = nil
        }
    }
}

public struct RouterView<Content: View>: View {
    @StateObject private var router: Router
    private let content: Content
    
    public init(parentRouter: Router? = nil, @ViewBuilder content: () -> Content) {
        _router = StateObject(wrappedValue: Router(parent: parentRouter))
        self.content = content()
    }
    
    public var body: some View {
        NavigationStack(path: $router.navigationPath) {
            content
                .navigationDestination(for: RouteDestination.self) { destination in
                    if let view = Router.view(for: destination) {
                        view
                    } else {
                        // TODO: maybe inject some defaultView
                        Text("Unknown route: \(destination.path)")
                    }
                }
        }
        .modifier(ModalPresenter(parent: router))
        .environment(\.router, router)
    }
}

private struct ModalPresenter: ViewModifier {
    @ObservedObject fileprivate var parent: Router
    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        content
            .sheet(item: $parent.presentedSheetDestination, onDismiss: {
                parent.presentedSheetDestination = nil
            }, content: { destination in
                RouterView(parentRouter: parent) {
                    Router.view(for: destination)
                }
            })
            .fullScreenCover(item: $parent.presentedFullScreenCoverDestination, onDismiss: {
                parent.presentedFullScreenCoverDestination = nil
            }, content: { destination in
                RouterView(parentRouter: parent) {
                    Router.view(for: destination)
                }
            })
            .onChange(of: parent.dismissPresentedView) {
                dismiss()
            }
    }
}
