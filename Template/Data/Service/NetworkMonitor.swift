//
//  NetworkMonitor.swift
//  Template
//
//  Created by Martin Kock on 08/04/2025.
//


//
//  NetworkMonitor.swift
//  Dev
//
//  Created by Martin Kock on 31/03/2024.
//

import Foundation
import Network

@Observable
class NetworkMonitor {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = true

    init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            Task {
                await MainActor.run {
                    self.isConnected = path.status == .satisfied
                }
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
