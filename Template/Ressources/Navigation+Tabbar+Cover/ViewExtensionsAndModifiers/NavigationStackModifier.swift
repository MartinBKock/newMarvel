//
//  WrapInNavStack.swift
//  NavTest
//
//  Created by Martin Kock on 22/11/2024.
//

import SwiftUI

struct WrapInNavStack: ViewModifier {
    var tab: NavigationController.Destinations
    @Bindable var navigationController: NavigationController
    private func bindingForTab() -> Binding<[NavigationController.NavigationDest]> {
        Binding(
            get: {
                navigationController.destinationPaths[tab] ?? []
            },
            set: { newValue in
                navigationController.destinationPaths[tab] = newValue
            }
        )
    }

    func body(content: Content) -> some View {
        NavigationStack(path: bindingForTab()) {
            content
                .navigationDestination(for: NavigationController.NavigationDest.self) { destination in
                    destination.view
                }
                .ignoresSafeArea(edges: .top)
                .tag(tab)
        }
    }
}

extension View {
    func wrapInNavStack(_ tab: NavigationController.Destinations) -> some View {
        self.modifier(WrapInNavStack(tab: tab, navigationController: Injector[\.nav]))
            .tag(tab)
    }
}
