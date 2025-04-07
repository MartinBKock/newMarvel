//
//  Destinations.swift
//  NavTest
//
//  Created by Martin Kock on 22/11/2024.
//
import SwiftUI

extension NavigationController: @unchecked Sendable {
    
    /// If adding a new Destination which needs a Navigation Stack, go to NavigationController and add an item to destinationPaths
    enum Destinations: CaseIterable {
        case standard
        
        var shouldDisplayInTabBar: Bool {
            switch self {
            default: return false
            }
        }
        
        func getNameString() -> String? {
            switch self {
            default: return nil
            }
        }
        
        func getNameText() -> Text? {
            switch self {
            default: return nil
            }
        }
        
        func getIcon() -> Image? {
            switch self {
            default: return nil
            }
        }
        
        @ViewBuilder
        func getTabBarView() -> some View {
            switch self {
            default:  Text("")
                
            }
        }
    }
    func tabSelection() -> Binding<Destinations> {
        Binding {
            self.currentSelectedTab
        } set: { tappedTab in
            self.currentSelectedTab = tappedTab
        }
    }
}
