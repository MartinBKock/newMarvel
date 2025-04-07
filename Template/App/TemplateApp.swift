//  Created by Martin Kock on 29/09/2023.
//

import SwiftUI


@main
struct TemplateApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    var body: some Scene {
        
        WindowGroup {
            ContentView()
        }
    }
}
