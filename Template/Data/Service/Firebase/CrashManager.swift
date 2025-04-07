//
//  CrashManager.swift
//  Template
//
//  Created by Martin Kock on 24/11/2024.
//
import FirebaseCrashlytics


final class CrashManager {
    
    init() {}
    
    func setUserId(userId: String) {
        Crashlytics.crashlytics().setUserID(userId)
    }
    
    private func setValue(value: String, key: String) {
        Crashlytics.crashlytics().setCustomValue(value, forKey: key)
    }
    
    func addLog(_ message: String) {
        Crashlytics.crashlytics().log(message)
    }
}
