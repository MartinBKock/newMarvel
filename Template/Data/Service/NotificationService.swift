//  Created by Martin Kock on 29/09/2023.
//

import Foundation

actor NotificationService: NSObject {
    
    // MARK: - Singleton
    static let shared = NotificationService()
    
    // MARK: - Private init
    private override init() {}
    
    // MARK: - Public enums
    enum CustomNotification: String {
        case Test
    }
    
    // MARK: - Public properties
    // Using CustomNotification
    func post(_ notification: CustomNotification, object : Any?) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: notification.rawValue), object: object)
    }
    
    func addObserver(selectorClass: Any, name: CustomNotification, selector: Selector, object: Any?) {
        NotificationCenter.default.addObserver(selectorClass, selector: selector, name: NSNotification.Name(rawValue: name.rawValue), object: object)
    }
    
    func removeObserver(selectorClass: Any, name: CustomNotification, object: Any?) {
        NotificationCenter.default.removeObserver(selectorClass, name: NSNotification.Name(rawValue: name.rawValue), object: object)
    }
    
    // Using Notication.Name
    func post(_ notification: Notification.Name, object : Any?) {
        NotificationCenter.default.post(name: notification, object: object)
    }
    
    func addObserver(selectorClass: Any, name: Notification.Name, selector: Selector, object: Any?) {
        NotificationCenter.default.addObserver(selectorClass, selector: selector, name: name, object: object)
    }
    
    func removeObserver(selectorClass: Any, name: Notification.Name, object: Any?) {
        NotificationCenter.default.removeObserver(selectorClass, name: name, object: object)
    }
    
    
    
    
}

