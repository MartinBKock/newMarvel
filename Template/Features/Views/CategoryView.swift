//
//  CategoryView.swift
//  Dev
//
//  Created by Martin Kock on 31/03/2024.
//

import SwiftUI

struct CategoryView: View {
    var stateController = Injector[\.state]
    var body: some View {
        NavigationStack {
            ZStack {
                Consts.Colors.backgroundPrimary
                    .ignoresSafeArea()
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                    ForEach(stateController.cats, id: \.self) { cat in
                        NavigationLink(destination: CategoryItemList(category: cat)) {
                            CategoryCell(category: cat)
                                .frame(height: 120)
                                .padding()
                        }
                    }
                })
            }
        }
    }
}

#Preview {
    CategoryView()
}
