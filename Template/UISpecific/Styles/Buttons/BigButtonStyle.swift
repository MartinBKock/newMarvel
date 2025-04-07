//
//  BigButtonStyle.swift
//  Template
//
//  Created by Martin Kock on 24/11/2024.
//

import SwiftUI

struct BigButtonStyle: ButtonStyle {
    var isLoading: Bool = false
    var backgroundColor: Color = .black
    var textColor: Color = .white
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .textStyle(.btn_default, color: isLoading ? Color.clear : textColor)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                Capsule(style: .continuous).fill(backgroundColor)
            )
            .overlay {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(textColor)
                }
            }
    }
}
