//
//  URLQueryItemsBuilder.swift
//  MyFoundation
//
//  Created by 杜晔 on 2025/5/12.
//

import Foundation

public extension URL {
    
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

public extension URLComponents {
    
    var queryParameters: [String: String?] {
        (queryItems ?? []).reduce(into: [String: String?](), { $0[$1.name] = $1.value })
    }
}
