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
        return pathComponents.dropFirst().joined(separator: "/")
    }
    
    var queryAllowedEncoded: URL? {
        URL(string: absoluteString.urlQueryAllowedEncoding)
    }
    
    var queryParameters: [String: String?] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return [:] }
        return components.queryParameters
    }
    
    var compactQueryParameters: [String: String] {
        queryParameters.compactMapValues({ $0 })
    }
    
    mutating func addParameterIfNotExist(key: String, value: String) {
        self = addedParameterIfNotExist(key: key, value: value)
    }
    
    func addedParameterIfNotExist(key: String, value: String) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false),
              !(components.queryItems ?? []).map({ $0.name }).contains(key) else { return self }
        components.queryItems = (components.queryItems ?? []) + [URLQueryItem(name: key, value: value)]
        return components.url ?? self
    }
    
    mutating func addOrUpdateParameter(key: String, value: String) {
        self = addedOrUpdatedParameter(key: key, value: value)
    }
    
    func addedOrUpdatedParameter(key: String, value: String) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return self }
        let queryItems = components.queryItems ?? []
        if queryItems.contains(where: { $0.name == key }) {
            components.queryItems = queryItems.map {
                $0.name == key ? URLQueryItem(name: key, value: value) : $0
            }
        } else {
            components.queryItems = queryItems + [URLQueryItem(name: key, value: value)]
        }
        return components.url ?? self
    }
}

public extension URLComponents {
    
    var queryParameters: [String: String?] {
        (queryItems ?? []).reduce(into: [String: String?](), { $0[$1.name] = $1.value })
    }
    
    var compactQueryParameters: [String: String] {
        queryParameters.compactMapValues({ $0 })
    }
}

// MARK: - URL Builder
public extension URL {
    
    init?(scheme: String = "https", host: String, path: String, @URLQueryItemsBuilder _ queryItems: () -> [URLQueryItem] = { [] }) {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path.hasPrefix("/") ? path : "/\(path)"
        components.queryItems = queryItems()
        guard let url = components.url else {
            return nil
        }
        self = url
    }
}

@resultBuilder public struct URLQueryItemsBuilder {
    
    public static func buildBlock(_ components: URLQueryItem...) -> [URLQueryItem] {
        components
    }
    
    public static func buildEither(first component: [URLQueryItem]) -> [URLQueryItem] {
        component
    }
    
    public static func buildEither(second component: [URLQueryItem]) -> [URLQueryItem] {
        component
    }
    
    public static func buildExpression(_ expression: URLQueryItem) -> [URLQueryItem] {
        [expression]
    }
    
    public static func buildExpression(_ expression: ()) -> [URLQueryItem] {
        []
    }
    
    public static func buildBlock(_ components: [URLQueryItem]...) -> [URLQueryItem] {
        components.flatMap { $0 }
    }
    
    public static func buildOptional(_ component: [URLQueryItem]?) -> [URLQueryItem] {
        component ?? []
    }
    
    public static func buildArray(_ components: [[URLQueryItem]]) -> [URLQueryItem] {
        Array(components.joined())
    }
}

// MARK: - Url Encoding String Percent Encoding
public extension String {
    
    var queryEscaped: String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        return addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? self
    }
    
    /// - Note:
    ///   For URL escaping, use urlQueryAllowedEncoding instead. For example,
    ///   "%25%E4%BD%A0%E5%A5%BD".escaped returns "%2525%25E4%25BD%25A0%25E5%25A5%25BD", but "%25%E4%BD%A0%E5%A5%BD" is expected.
    var escaped: String {
        guard let result = addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return self }
        return result
    }
    
    var urlQueryAllowedEncoding: String {
        let value = removingPercentEncoding ?? self
        guard let result = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return self }
        return result
    }
    
    var asciiEncoding: String {
        guard let data = data(using: .ascii, allowLossyConversion: true),
              let output = String(data: data, encoding: .ascii) else {
            return ""
        }
        return output
    }
}
