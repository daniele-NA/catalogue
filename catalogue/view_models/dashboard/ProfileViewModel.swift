import Foundation
import Combine
import FirebaseAuth

final class ProfileViewModel: ObservableObject {
    
    func logout(){
        do {
            try Auth.auth().signOut()
            print("Logout riuscito")
        } catch {
            print("Errore durante il logout: \(error.localizedDescription)")
        }
    }
}
