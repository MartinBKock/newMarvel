//
//  Fonts.swift
//  Dev
//
//  Created by Martin Kock on 23/11/2024.
//
import SwiftUI

struct Fonts: Equatable, Hashable, Sendable {
    private init(font: Font) {
        self.font = font
    }
    
    let font: Font
    
    static func standard(_ style: Font.TextStyle, fontSize: Double? = nil, weight: Font.Weight? = nil) -> Fonts {
        let name = "Inter-Regular_\(weightName(of: weight ?? defaultWeight(for: style)))"
        let size = fontSize ?? size(of: style)
        return Fonts(font: .custom(name, size: size, relativeTo: style))
    }
    
    static func italic(_ style: Font.TextStyle, fontSize: Double? = nil, weight: Font.Weight? = nil) -> Fonts {
        let name = "Inter-Regular_\(weightName(of: weight ?? defaultWeight(for: style)))-Italic"
        let size = fontSize ?? size(of: style)
        return Fonts(font: .custom(name, size: size, relativeTo: style))
    }
    
    static var extraBoldFontName = "Inter-Regular_ExtraBold"
    
    
    private static func weightName(of weight: Font.Weight) -> String {
        switch weight {
        case .ultraLight:   "UltraLight"
        case .thin:         "Thin"
        case .light:        "Light"
        case .regular:      "Regular"
        case .medium:       "Medium"
        case .semibold:     "Semibold"
        case .bold:         "Bold"
        case .heavy:        "Heavy"
        case .black:        "Black"
        default:            "Regular"
        }
    }
    
    private static func defaultWeight(for style: Font.TextStyle) -> Font.Weight {
        switch style {
        case .extraLargeTitle:  .bold
        case .extraLargeTitle2: .bold
        case .largeTitle:       .regular
        case .title:            .regular
        case .title2:           .regular
        case .title3:           .regular
        case .headline:         .semibold
        case .subheadline:      .regular
        case .body:             .regular
        case .callout:          .regular
        case .footnote:         .regular
        case .caption:          .regular
        case .caption2:         .regular
        @unknown default:       .regular
        }
    }
    
    private static func size(of style: Font.TextStyle) -> Double {
        switch style {
        case .extraLargeTitle:  36.0
        case .extraLargeTitle2: 28.0
        case .largeTitle:       34.0
        case .title:            28.0
        case .title2:           22.0
        case .title3:           20.0
        case .headline:         17.0
        case .subheadline:      15.0
        case .body:             17.0
        case .callout:          16.0
        case .footnote:         13.0
        case .caption:          12.0
        case .caption2:         11.0
        @unknown default:       17.0
        }
    }
}
