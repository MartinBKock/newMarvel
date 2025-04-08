//
//  CreatorDetail.swift
//  Dev
//
//  Created by Martin Kock on 03/04/2024.
//

import SwiftUI

struct CreatorDetail: View {
    var creator: CreatorResult?
    var body: some View {
        ZStack {
            Consts.Colors.backgroundPrimary.ignoresSafeArea()
            Text(creator?.fullName ?? "UNKNOWNNAME".localized)
        }
    }
}

#Preview {
    CreatorDetail()
}
