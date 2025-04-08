//
//  HistoryDetail.swift
//  Dev
//
//  Created by Martin Kock on 03/04/2024.
//

import SwiftUI

struct StoryDetail: View {
    var story: StoryResult?
    var body: some View {
        ZStack {
            Consts.Colors.backgroundPrimary.ignoresSafeArea()
            Text(story?.title ?? "UNKNOWNSTORY".localized)
        }
    }
}

#Preview {
    StoryDetail()
}
