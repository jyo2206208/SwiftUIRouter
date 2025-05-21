//
//  RootTabs.swift
//  MyService
//
//  Created by 杜晔 on 2025/5/13.
//

import Foundation

public enum RootTabs: Int, Codable, CaseIterable, Identifiable {

    public var id: String { "\(self)" }

    case home
    case book
    case trip
    case me
}
