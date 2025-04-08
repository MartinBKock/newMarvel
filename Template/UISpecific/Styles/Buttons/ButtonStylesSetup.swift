//
//  ButtonStyles.swift
//  Template
//
//  Created by Martin Kock on 24/01/2025.
//

import SwiftUI

//import MBUI

enum buttonStyles {
    case small, big
}


@ViewBuilder
func MBBtn(_ style: buttonStyles = .small, text: String, isLoading: Bool = false, action: @escaping () -> Void) -> some View {
        switch style {
        case .small:
            Button(action: action) {
                Text(text)
            }
            .buttonStyle(SmallButtonStyle(isLoading: isLoading))
        case .big:
            Button(action: action) {
                Text(text)
            }
            .buttonStyle(BigButtonStyle(isLoading: isLoading))
        default:
            Button(action: action) {
                Text(text)
            }
            .buttonStyle(SmallButtonStyle(isLoading: isLoading))
        }
    }

enum ImagePosition {
    case left
    case right
}

@ViewBuilder
func MBBtn(
    _ style: buttonStyles,
    isLoading: Bool = false,
    text: String,
    image: Image? = nil,  // Optional Image view
    imagePosition: ImagePosition = .left,
    action: @escaping () -> Void
) -> some View {
    Button(action: action) {
        HStack(spacing: 8) {
            if let image = image {
                if imagePosition == .left {
                    image
                }
                
                Text(text)
                
                if imagePosition == .right {
                    image
                }
            } else {
                Text(text)
            }
        }
    }
    .buttonStyle(BigButtonStyle(isLoading: isLoading))
}

struct TestView: View {
    @State private var isLoading = true
    var body: some View {
        VStack {
            MBBtn(.small, text: "Small Button", isLoading: false, action: {})
            MBBtn(.small, text: "Small Button", isLoading: true, action: {})
            MBBtn(.small, text: "Small Button", isLoading: isLoading, action: {})
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLoading.toggle()
                    }
                }
            MBBtn(.big, text: "Big Button", action: {})
            MBBtn(.big, text: "Big Button with Image", image: Image(systemName: "plus"), action: {})
            MBBtn(.big, text: "Big Button with Image", image: Image(systemName: "plus"), imagePosition: .right, action: {})
        }
    }
}

#Preview {
    TestView()
        .padding(.horizontal, 16)
}
