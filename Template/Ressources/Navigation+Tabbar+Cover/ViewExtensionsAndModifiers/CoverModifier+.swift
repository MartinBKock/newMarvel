//
//  WrapInCover.swift
//  NavTest
//
//  Created by Martin Kock on 22/11/2024.
//
import SwiftUI

struct WrapInCover: ViewModifier {
    @Bindable var navigationController: NavigationController
    func body(content: Content) -> some View {
        content
            .cover(isPresented: $navigationController.shouldShowCover, transition: .move(edge: .bottom)) {
                navigationController.coverDestStack.last?.view
            }
    }
}



extension View {
    func wrapInCover() -> some View {
        self.modifier(WrapInCover(navigationController: Injector[\.nav]))
    }
}


struct Cover<Content: View>: View {
    @Binding var isPresented: Bool
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            content
                .environment(
                    \.easyDismiss,
                     EasyDismiss {
                         isPresented = false
                     })
        }
    }
}

extension View {
    func cover<Content>(
        isPresented: Binding<Bool>, transition: AnyTransition = .move(edge: .bottom),
        content: @escaping () -> Content
    ) -> some View where Content: View {
        ZStack {
            self
            ZStack {
                if isPresented.wrappedValue {
                    Cover(isPresented: isPresented, content: content)
                        .transition(transition)
                }
            }
        }
    }
}

struct EasyDismiss {
    private var action: () -> Void
    func callAsFunction() {
        action()
    }
    
    init(action: @escaping () -> Void = {}) {
        self.action = action
    }
}

struct EasyDismissKey: EnvironmentKey {
    static var defaultValue: EasyDismiss = EasyDismiss()
}

extension EnvironmentValues {
    var easyDismiss: EasyDismiss {
        get { self[EasyDismissKey.self] }
        set { self[EasyDismissKey.self] = newValue }
    }
}
