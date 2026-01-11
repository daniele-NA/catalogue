import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore


// == Used into all the classes == //
final class AuthViewModel: ObservableObject {
    
    
    public static var user: User? = Auth.auth().currentUser
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var error: String? = nil
    
    init(username: String = "", email: String = "", password: String = "", error: String? = nil) {
        self.username = username
        self.email = email
        self.password = password
        self.error = error
    }
    
    func tryLogin() {
        authenticate(isRegister: false)
    }
    
    func tryRegister() {
        authenticate(isRegister: true)
    }
    
    private func authenticate(isRegister: Bool) {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard isValidString(trimmedEmail),
              isValidString(trimmedPassword),
              trimmedEmail.contains("@"),
              trimmedEmail.contains(".")
        else {
            error = "Credenziali non valide"
            return
        }
        
        error = nil
        print("\(isRegister ? "Register" : "Login") with \(trimmedEmail) | \(trimmedPassword)")
        
        
        // == Send notification == //
        NotificationSender().sendWelcomeNotification()
        
        if isRegister {
            Auth.auth().createUser(withEmail: trimmedEmail, password: trimmedPassword) { [weak self] result, err in
                self?.handleAuth(result: result, err: err, isRegister: true, email: trimmedEmail)
            }
        } else {
            Auth.auth().signIn(withEmail: trimmedEmail, password: trimmedPassword) { [weak self] result, err in
                self?.handleAuth(result: result, err: err, isRegister: false, email: trimmedEmail)
            }
        }
    }
    
    private func handleAuth(result: AuthDataResult?, err: Error?, isRegister: Bool, email: String) {
        if let err = err {
            error = err.localizedDescription
            print("Error with firebase \(err.localizedDescription)")
        } else {
            error = nil
            print("\(isRegister ? "Registrazione" : "Login") riuscito")
            
            if isRegister, let user = result?.user {
                let newUser = UserDto(
                    id: user.uid,
                    name: username,
                    email: email,
                    joined: Date().timeIntervalSince1970
                )
                
                
                let db = Firestore.firestore()
                
                db.collection("users").document(user.uid)
                    .setData([
                        "id": user.uid,
                        "name": username,
                        "email": email,
                        "joined": newUser.joined]){
                            err in
                            
                            if(err != nil){
                                print("Error while inserting Item \(err?.localizedDescription)")
                            } else  {
                                print("Nuovo utente creato: \(newUser)")
                            }
                        }
                
              
            }
        }
    }
    
    private func isValidString(_ str: String) -> Bool {
        !str.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

