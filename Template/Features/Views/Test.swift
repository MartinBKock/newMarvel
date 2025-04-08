//
//  Test.swift
//  Dev
//
//  Created by Martin Kock on 31/03/2024.
//

import SwiftUI

struct Test: View {
    var stateController = Injector[\.state]
    var body: some View {
        VStack {
            if stateController.chars.isEmpty {
                ProgressView()
            } else {
//                AsyncImageView(urlString:"\(stateController.chars.first?.thumbnail?.path ?? "")/portrait_xlarge.jpg")
            }
        }.onChange(of: Injector[\.monitor].isConnected) {
            if Injector[\.monitor].isConnected {
                if stateController.chars.isEmpty {
                    Task {
                        await stateController.fetchAllChars()
                    }
                }
            }
        }
    }
}

#Preview {
    Test()
}
