//
//  AlertView.swift
//  Dev
//
//  Created by Martin Kock on 30/04/2024.
//

import SwiftUI

struct AlertView: View {
    @State var showAlert = true
    var error: Error?
    var body: some View {
        VStack {
            
        }
        .alert("ERROR", isPresented: $showAlert) {
            
        } message: {
            Text(error?.localizedDescription ?? "")
        }

    }
}

#Preview {
    AlertView()
}
