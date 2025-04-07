//
//  CoverDestination.swift
//  NavTest
//
//  Created by Martin Kock on 22/11/2024.
//

import SwiftUI

extension NavigationController {
    enum CoverDest {
        case view1(String)
        case view2
    }
}

extension NavigationController.CoverDest {
    @ViewBuilder
    var view: some View {
        switch self {
        case .view1(let text):
            ZStack {
                Color.black
                Text(text)
                    .foregroundStyle(.white)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            Injector[\.nav].presentCover(.view2)
                        }
                    }
            }
            .ignoresSafeArea()
            
            
        case .view2:
            Color.red
                .ignoresSafeArea(edges: .all)
                .onTapGesture {
                    withAnimation(.easeOut) {
                        Injector[\.nav].dismissAllCovers()
                    }
                }
                
        }
    }
}
