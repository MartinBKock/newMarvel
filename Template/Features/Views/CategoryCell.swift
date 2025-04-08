//
//  CategoryCell.swift
//  Dev
//
//  Created by Martin Kock on 30/03/2024.
//

import SwiftUI

struct CategoryCell: View {
    var category = "hej"
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Consts.Colors.BoxColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.black, lineWidth: 2)
                )
            Text(category)
                .foregroundStyle(Consts.Colors.textSecondary)
                .font(.title3)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    CategoryCell()
}
