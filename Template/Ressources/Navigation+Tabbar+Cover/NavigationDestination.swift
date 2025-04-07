//
//  Destination.swift
//  NavTest
//
//  Created by Martin Kock on 22/11/2024.
//

import SwiftUI

extension NavigationController {
    enum NavigationDest: Hashable {
        case view1(text: String)
        case view2
    }
}
extension NavigationController.NavigationDest {
    @ViewBuilder
    var view: some View {
        switch self {
        case .view1(let text):
            ZStack {
                Color.black
                Text(text)
                    .foregroundStyle(.white)
            }
                .ignoresSafeArea(edges: .top)
                .onTapGesture {
                    Injector[\.nav].push(.view2)
                }
        case .view2:
            Color.red
                .ignoresSafeArea(edges: .all)
                .onTapGesture {
                    Injector[\.nav].popToRoot()
                }
        }
    }
}
