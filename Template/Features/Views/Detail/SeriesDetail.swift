//
//  SeriesDetail.swift
//  Dev
//
//  Created by Martin Kock on 03/04/2024.
//

import SwiftUI

struct SeriesDetail: View {
    var series: SeriesResult?
    var body: some View {
        ZStack {
            Consts.Colors.backgroundPrimary.ignoresSafeArea()
            Text(series?.title ?? "UNKNOWNSERIES".localized)
        }
    }
}

#Preview {
    SeriesDetail()
}
