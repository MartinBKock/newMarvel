//
//  Injector.swift
//  Template
//
//  Created by Martin Kock on 25/11/2024.
//
import Foundation
@dynamicMemberLookup


public class Injector {
    
    // MARK: - Injectable values
    // Services
    @MainActor
    lazy var auth = FirebaseAuthService()
    lazy var firestore = FirestoreService()
    lazy var crash = CrashManager()
    lazy var network = NetworkService()
    lazy var initialization = InitializationService()
    
    // Controllers
    lazy var test = TemplateController()
    lazy var nav = NavigationController()
    
    
    // MARK: - Implementation
    fileprivate static let threadInjectorInstanceKey = "injector_instance"
    nonisolated(unsafe) fileprivate static let shared = Injector()
    private init() { }
    
    /// This function should only be used for testing. All instances created inside the block will use the injector parsed to the block.
    static func withMocking(_ block: (_ injector: Injector) -> Void) {
        let injector = Injector()
        Thread.current.threadDictionary[threadInjectorInstanceKey] = injector
        block(injector)
        Thread.current.threadDictionary[threadInjectorInstanceKey] = nil
    }
    
    static subscript<T>(_ member: KeyPath<Injector, T>) -> T {
        if let injector = Thread.current.threadDictionary[threadInjectorInstanceKey] as? Injector {
            return injector[keyPath: member]
        } else {
            return shared[keyPath: member]
        }
    }
    
    // Nicer solution, but it auto completion doesn't work for some reason.
    static subscript<T>(dynamicMember member: KeyPath<Injector, T>) -> T {
        if let injector = Thread.current.threadDictionary[threadInjectorInstanceKey] as? Injector {
            return injector[keyPath: member]
        } else {
            return shared[keyPath: member]
        }
    }
    
//    @InjectableFactory
//    var cubeScrambler: CubeScrambler = CubeRandomScrambler()
}
// MARK: - Helpers
@propertyWrapper class InjectableFactory<Value> {
    private var creator: () -> Value
    
    init(wrappedValue: @autoclosure @escaping () -> Value) {
        creator = wrappedValue
    }
    var wrappedValue: Value {
        get { creator() }
        set { creator = { newValue } }
    }
}
