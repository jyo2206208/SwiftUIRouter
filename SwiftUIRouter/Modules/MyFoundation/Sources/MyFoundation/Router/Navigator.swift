//
//  Router.swift
//  MyFoundation
//
//  Created by 杜晔 on 2025/4/24.
//

import Foundation
import SwiftUI
import Combine

public enum Owner: Int, Sendable {

    case root
    case presenter
}

final class ApplicationRouter: ObservableObject {

    let rootRouters: [Router]
    @Published public var selectedTab: Int = 0

    init(rootRouters: [Router]) {
        self.rootRouters = rootRouters
    }
}

public final class Router: ObservableObject, @unchecked Sendable {

    private let parent: Router?
    private let owner: Owner

    public init(parent: Router? = nil, owner: Owner) {
        self.parent = parent
        self.owner = owner
    }
    
    @Published fileprivate var navigationPath = NavigationPath()
    @Published fileprivate var presentedSheetDestination: RouteDestination?
    @Published fileprivate var presentedFullScreenCoverDestination: RouteDestination?
    @Published fileprivate var dismissPresentedView: Bool?
    @Published fileprivate var selectedTab: Int = 0
}

@MainActor
extension Router {

    private static var routeHandlers: [String: RouteHandler.Type] = [:]

    fileprivate static func view(for destination: RouteDestination) -> AnyView? {
        Router.routeHandlers[destination.path].map {
            AnyView($0.view(for: destination))
        }
    }

    private static func canNavigate(for destination: RouteDestination) -> Bool {
        Router.routeHandlers[destination.path] != nil
    }
}

@MainActor
public extension Router {

    static func register(handlers: [RouteHandler.Type]) {
        handlers.forEach {
            routeHandlers[$0.path] = $0
        }
    }

    func navigate(to path: String,
                  type: NavigationType = .push,
                  param: Any? = nil) {
        let destination = RouteDestination(path: path, param: param)
        guard Self.canNavigate(for: destination) else { return }
        switch type {
        case .push:
            navigationPath.append(destination)
        case .sheet:
            presentedSheetDestination = destination
        case .fullScreenCover:
            presentedFullScreenCoverDestination = destination
        }
    }

    func switchTab(to index: Int) {
        selectedTab = index
    }

    func openURL(url: URL) {
        let pathString = url.pathString
        let param = url.compactQueryParameters
        navigate(to: pathString, type: .push, param: param)
    }

    func dismiss() {
        if navigationPath.isEmpty {
            dismissPresentedView = true
        } else {
            navigationPath.removeLast()
        }
    }

    func dismissAllModal() {
        switch owner {
        case .root:
            presentedSheetDestination = nil
            presentedFullScreenCoverDestination = nil
        case .presenter:
            parent?.dismissAllModal()
        }
    }

    func dismissAll() {
        switch owner {
        case .root:
            navigationPath.removeLast(navigationPath.count)
            presentedSheetDestination = nil
            presentedFullScreenCoverDestination = nil
        case .presenter:
            parent?.dismissAll()
        }
    }
}

public struct RouterView<Content: View>: View {
    @StateObject private var router: Router
    private let content: Content

    @EnvironmentObject var applicationRouter: ApplicationRouter

    public init(router: StateObject<Router>, @ViewBuilder content: () -> Content) {
        _router = router
        self.content = content()
    }

    public var body: some View {
        NavigationStack(path: $router.navigationPath) {
            content
                .navigationDestination(for: RouteDestination.self) { destination in
                    if let view = Router.view(for: destination) {
                        view
                    }
                }
        }
        .onReceive(router.$selectedTab) {
            applicationRouter.selectedTab = $0
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
                RouterView(router: .init(wrappedValue: .init(parent: parent, owner: .presenter))) {
                    Router.view(for: destination)
                }
            })
            .fullScreenCover(item: $parent.presentedFullScreenCoverDestination, onDismiss: {
                parent.presentedFullScreenCoverDestination = nil
            }, content: { destination in
                RouterView(router: .init(wrappedValue: .init(parent: parent, owner: .presenter))) {
                    Router.view(for: destination)
                }
            })
            .onChange(of: parent.dismissPresentedView) {
                dismiss()
            }
    }
}
