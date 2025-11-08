import FirebaseCore
import SwiftUI

@main
struct catalogueApp: App {
    
    init()
    {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            BaseView()
        }
    }
}
