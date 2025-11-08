import SwiftUI
import FirebaseAuth


// FIXME (FIX THE LISTENER)
struct BaseView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if AuthViewModel.user != nil {
                DashboardView()
            } else {
                LoginView(viewModel: viewModel)
            }
        }
        .onAppear {
            // Listener che resta attivo finché la view è in memoria
            Auth.auth().addStateDidChangeListener { _, user in
                DispatchQueue.main.async {
                    AuthViewModel.user = user
                }
            }
        }
    }
}
