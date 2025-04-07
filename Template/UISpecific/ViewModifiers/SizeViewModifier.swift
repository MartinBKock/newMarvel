//
//  WidthViewModifier.swift
//  Template
//
//  Created by Martin Kock on 24/11/2024.
//

import SwiftUI

struct SizeViewModifier: ViewModifier {
    @Binding var size: CGSize
    var shouldPrint: Bool = false
    
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo -> Color in
                DispatchQueue.main.async {
                    size = geo.size
                    if shouldPrint {
                        print("Size: \(size)")
                    }
                }
                return Color.clear
            }
        )
    }
}

extension View {
    func sizeReader(_ size: Binding<CGSize>, shouldPrint: Bool = false) -> some View {
        self.modifier(SizeViewModifier(size: size, shouldPrint: shouldPrint))
    }
}
