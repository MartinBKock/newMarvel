//
//  EventsDetail.swift
//  Dev
//
//  Created by Martin Kock on 03/04/2024.
//

import SwiftUI

struct EventsDetail: View {
    var event: EventResult?
    var body: some View {
        ZStack {
            Consts.Colors.backgroundPrimary.ignoresSafeArea()
            Text(event?.title ?? "UKNOWNEVENT".localized)
        }
    }
}

#Preview {
    EventsDetail()
}
