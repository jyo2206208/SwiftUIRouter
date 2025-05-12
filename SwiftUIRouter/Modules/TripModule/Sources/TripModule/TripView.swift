//
//  TripView.swift
//  TripModule
//
//  Created by 杜晔 on 2025/4/23.
//

import SwiftUI

struct Value: Identifiable {
    var id: String {
        modalValue
    }
    let modalValue: String
}

public struct TripView: View {

    @Environment(\.dismiss) var dismiss

    @State var sheetValue: Value?
    @State var fullScreenCoverValue: Value?

    public var body: some View {
        VStack {
            NavigationStack {
                NavigationLink("push a new view") {
                    TripView()
                }
                Button("sheet a new view") {
                    sheetValue = Value(modalValue: "sheet")
                }

                Button("fullScreenCover a new view") {
                    fullScreenCoverValue = Value(modalValue: "fullScreen")
                }

                Button("dissmiss") {
                    dismiss()
                }
            }.sheet(item: $sheetValue) { _ in
                TripView()
            }.fullScreenCover(item: $fullScreenCoverValue) { _ in
                TripView()
            }
        }
    }
    public init() {}
}

#Preview {
    TripView()
}
