//
//  AppDelegate.swift
//  Template
//
//  Created by Martin Kock on 06/12/2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
//import FirebaseMessaging
import FirebaseCrashlytics
import MBLog


class AppDelegate: NSObject, UIApplicationDelegate {
    
    //    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    //            Auth.auth().setAPNSToken(deviceToken, type: AuthAPNSTokenType.prod)
    //            Messaging.messaging().apnsToken = deviceToken
    //      }
    //
    //      func application(_ application: UIApplication,
    //                       didReceiveRemoteNotification notification: [AnyHashable : Any],
    //                       fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    //            if Auth.auth().canHandleNotification(notification) {
    //                  completionHandler(.noData)
    //                  return
    //            }
    //      }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
#if DEBUG
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
#else
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
#endif
        
#if DEBUG
        MBLog.addLoggers(
            CustomDebugLogger()
        )
        MBLog.implementLoggingFor([
            .swizzleViewDidLoad
        ])
#endif
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
    
}
