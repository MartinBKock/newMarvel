//
//  NavigationController.swift
//  NavTest
//
//  Created by Martin Kock on 10/11/2024.
//

import Foundation
import SwiftUI

@Observable
class NavigationController {
    // MARK: - Tabbar
    var currentSelectedTab: Destinations = .standard
    
    // MARK: - NavPaths
    var destinationPaths: [Destinations: [NavigationDest]] = [
        .standard: []
    ]
    
    // MARK: - Cover
    var coverDestStack: [CoverDest] = [] {
        didSet {
            shouldShowCover = !coverDestStack.isEmpty
        }
    }
    var shouldShowCover: Bool = false
}


// MARK: - NavPaths extension
extension NavigationController {
    func push(_ destination: NavigationDest) {
        destinationPaths[currentSelectedTab]?.append(destination)
    }
    
    func pop() {
        if !(destinationPaths[currentSelectedTab]?.isEmpty ?? false) {
            destinationPaths[currentSelectedTab]?.removeLast()
        }
    }
    
    func popToRoot() {
        destinationPaths[currentSelectedTab]?.removeAll()
    }
}

// MARK: - Cover extension
extension NavigationController {
    func presentCover(_ destination: CoverDest) {
        coverDestStack.append(destination)
    }
    func dismissCover() {
        if !coverDestStack.isEmpty {
            coverDestStack.removeLast()
            
        }
    }
    func dismissAllCovers() {
        coverDestStack.removeAll()
    }
}
