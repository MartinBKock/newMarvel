//
//  SmallButtonStyle.swift
//  Template
//
//  Created by Martin Kock on 24/11/2024.
//

import SwiftUI

struct SmallButtonStyle: ButtonStyle {
    var isLoading: Bool = false
    var backgroundColor: Color = .black
    var textColor: Color = .white
    var verticalPadding: CGFloat = 15
    var horizontalPadding: CGFloat = 0
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .textStyle(.btn_default, color: isLoading ? Color.clear : textColor)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding == 0 ? verticalPadding * 2 : horizontalPadding)
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

