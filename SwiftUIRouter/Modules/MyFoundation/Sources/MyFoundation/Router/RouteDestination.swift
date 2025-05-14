//
//  RouteDestination.swift
//  MyFoundation
//
//  Created by 杜晔 on 2025/5/12.
//

import Foundation
import SwiftUI

@MainActor
public protocol RouteHandler {
    
    static var path: String { get }

    static func view(for destination: RouteDestination) -> any View
}

public struct RouteDestination {
    
    public let param: Any?

    let path: String
    
    init(path: String, param: Any? = nil) {
        self.path = path
        self.param = param
    }
}

extension RouteDestination: Hashable, Identifiable {
    
    public var id: Int { hashValue }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(path)
    }
    
    public static func == (lhs: RouteDestination, rhs: RouteDestination) -> Bool {
        lhs.path == rhs.path
    }
}
