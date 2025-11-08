import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let user = AuthViewModel.user {
                    Text("UID: \(user.uid)").font(.caption)
                    Text("Email: \(user.email ?? "N/A")").font(.headline)
                } else {
                    Text("Nessun utente loggato")
                }

                Button {
                    viewModel.logout()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue)
                        Text("Logout")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .frame(height: 44)
                }
            }
            .padding()
            .navigationTitle("Profile")
        
        }
    }
}

#Preview {
    ProfileView()
}
