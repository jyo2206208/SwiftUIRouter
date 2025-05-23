//
//  Router.swift
//  SwiftUIRouter
//
//  Created by Ethan.Du on 2025/4/24.
//

import Foundation
import SwiftUI
import Combine

public enum Owner: Sendable {

    case root(Binding<Int>? = nil)
    case presenter
}

public enum NavigationType {

    case push
    case sheet
    case fullScreenCover
}

public final class Router: ObservableObject {

    private let parent: Router?
    private let owner: Owner

    init(parent: Router? = nil, owner: Owner) {
        self.parent = parent
        self.owner = owner
    }
    
    @Published fileprivate var navigationPath = NavigationPath()
    @Published fileprivate var presentedSheetDestination: RouteDestination?
    @Published fileprivate var presentedFullScreenCoverDestination: RouteDestination?
    @Published fileprivate var dismissPresentedView: Bool?
}

@MainActor
extension Router {

    private static var routeHandlers: [String: any RouteHandler.Type] = [:]

    fileprivate static func view(for destination: RouteDestination) -> AnyView? {
        Router.routeHandlers[destination.path]?.view(for: destination).map {
            AnyView($0)
        }
    }

    private static func canNavigate(for destination: RouteDestination) -> (any RouteHandler.Type)? {
        Router.routeHandlers[destination.path]
    }
}

@MainActor
public extension Router {

    static func root(_ seletedTab: Binding<Int>? = nil) -> Router { Router(owner: .root(seletedTab)) }

    static func register(handlers: [any RouteHandler.Type]) {
        handlers.forEach {
            routeHandlers[$0.path] = $0
        }
    }

    static func rootView(for tab: Int) -> AnyView {
        guard let view = routeHandlers.values.first (where: { $0.tabIfRoot == tab })?.view(for: .root) else {
            fatalError("Tab \(tab) is not registed as root!")
        }
        return AnyView(view)
    }

    func navigate(to path: String,
                  type: NavigationType = .push,
                  param: Any? = nil) {
        let destination = RouteDestination(path: path, param: param)
        guard let handler = Self.canNavigate(for: destination) else { return }
        if let tab = handler.tabIfRoot { switchTab(to: tab);return }
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
        switch owner {
        case let .root(selectedTab):
            selectedTab?.wrappedValue = index
        case .presenter:
            parent?.switchTab(to: index)
        }
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

private struct RouterViewModifier: ViewModifier {

    @StateObject private var router: Router

    func body(content: Content) -> some View {
        NavigationStack(path: $router.navigationPath) {
            content
                .navigationDestination(for: RouteDestination.self) { destination in
                    if let view = Router.view(for: destination) {
                        view
                    }
                }
        }
        .modifier(ModalPresenter(parent: router))
        .environment(\.router, router)
    }

    init(router: Router) {
        _router = .init(wrappedValue: router)
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
                Router.view(for: destination)?.router(.init(parent: parent, owner: .presenter))
            })
            .fullScreenCover(item: $parent.presentedFullScreenCoverDestination, onDismiss: {
                parent.presentedFullScreenCoverDestination = nil
            }, content: { destination in
                Router.view(for: destination)?.router(.init(parent: parent, owner: .presenter))
            })
            .onChange(of: parent.dismissPresentedView) {
                dismiss()
            }
    }
}

public extension View {

    func router(_ router: Router) -> some View {
        modifier(RouterViewModifier(router: router))
    }
}
