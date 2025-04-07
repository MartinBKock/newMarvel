//
//  InitializationService.swift
//  Template
//
//  Created by Martin Kock on 25/11/2024.
//


//
//  InitializationService.swift
//  PrepartyGames
//
//  Created by Martin Kock on 24/11/2024.
//

import Foundation

@Observable
final class InitializationService {
    init() {}
    
    var state: InitializationState = .notInitialized
    
    func initialize() {
        state = .initialized
    }
}



enum InitializationState {
    case initialized
    case notInitialized
}

