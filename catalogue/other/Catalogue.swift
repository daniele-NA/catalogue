import FirebaseCore
import SwiftUI
import UserNotifications

@main
struct catalogueApp: App {
    
    init()
    {
        FirebaseApp.configure()
        
        let center=UNUserNotificationCenter.current()

          // ASK FOR FULL NOTIFICATION PERMISSION , REQUIRES 3 FEATURES .alert etc etc //
          center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
              if let error = error {
                  print("Errore: \(error)")
                  DispatchQueue.main.async {
                      if let url = URL(string: UIApplication.openSettingsURLString) {
                          UIApplication.shared.open(url, options: [:], completionHandler: nil)
                      }
                  }
                  return
              }

              if granted {
                  print("Permesso notifiche concesso")
              } else {
                  DispatchQueue.main.async {
                      if let url = URL(string: UIApplication.openSettingsURLString) {
                          UIApplication.shared.open(url, options: [:], completionHandler: nil)
                      }
                  }
              }
          }
    }
    
    
    var body: some Scene {
        WindowGroup {
            BaseView()
        }
    }
}
