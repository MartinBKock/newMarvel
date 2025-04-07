//
//  AppTextStyleModifier.swift
//  Dev
//
//  Created by Martin Kock on 23/11/2024.
//


import SwiftUI
extension View {
    func textStyle(_ font: Consts.UI.Fonts, color: Color = .black) -> some View {
        modifier(AppTextStyle(font: font.font(), color: color))
    }
}
protocol AppTextStyleModifier: ViewModifier {}
struct AppTextStyle: ViewModifier {
    let font: Font
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundStyle(color)
    }
}
