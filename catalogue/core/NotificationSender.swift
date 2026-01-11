import Foundation
import UserNotifications



class NotificationSender{
    func sendWelcomeNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                // Richiedo il permesso se non è stato ancora dato
                center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        self.scheduleNotification()
                    }
                }
            case .denied:
                print("Permesso notifiche negato")
            case .authorized, .provisional, .ephemeral:
                self.scheduleNotification()
            @unknown default:
                print("Stato sconosciuto")
            }
        }
    }

    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Welcome!"
        content.body = "Welcome to Catalogue"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "welcome_notification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Errore nell'invio della notifica: \(error)")
            } else {
                print("Notifica programmata")
            }
        }
    }
    

    
}

