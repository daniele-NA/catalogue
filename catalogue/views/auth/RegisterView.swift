import SwiftUI

// command A  poi ctrl i
struct RegisterView: View {
    
    
    // == USIAMO OBSERVABLEOBJECT DATO CHE è EREDITATO DAL METODO CHIAMANTE == //
    @ObservedObject var viewModel:AuthViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.orange)
                    .frame(width: width, height: 320)
                    .offset(y: -150)
                
                
                VStack(spacing: 20) {
                    VStack(spacing: 30) {
                        Text("Register")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 80)
                    
                    Spacer()
                    
                    Form {
                        if viewModel.error != nil {
                            Text(viewModel.error ?? "")
                                .foregroundColor(.red)
                        }
                        
                        TextField("Username", text: $viewModel.username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Email Address", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button {
                            
                            viewModel.tryRegister()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.green)
                                Text("Registrati")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            .frame(height: 44)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    
                    VStack {
                        Text("Già registrato ?")
                        Button("Log with your Account") {
                            
                        }
                        .padding(.bottom, 50)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}
