//
//  UserDefaultsService.swift
//  RecipeAppFirebase
//
//  Created by Martin Kock on 18/09/2023.
//


import SwiftUI


@available(iOS 14.0, *)
actor UserDefaultsService {
    
    // MARK: - Singleton
    static let shared = UserDefaultsService()
    
    // MARK: - Private init
    private init() {}
    
    // MARK: - Public properties
    @AppStorage("example_string") var exampleString: String = "default"
    
    
    
    
}
