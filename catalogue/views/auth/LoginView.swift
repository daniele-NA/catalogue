import SwiftUI

// command A  poi ctrl i
struct LoginView: View {

    

    // == USIAMO OBSERVABLEOBJECT DATO CHE è EREDITATO DAL METODO CHIAMANTE == //
    @ObservedObject var viewModel:AuthViewModel
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                let width = geometry.size.width
                
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.pink)
                        .frame(width: width, height: 300)
                        .offset(y: -150)
                    
                    
                    VStack(spacing: 20) {
                        VStack(spacing: 10) {
                            Text("Catalogue")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.top, 80)
                        
                        Spacer()
                        
                        Form {
                            
                            if viewModel.error != nil {
                                Text(viewModel.error ?? "")
                                    .foregroundColor(.red)
                            }
                            
                            
                            TextField("Email Address", text: $viewModel.email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                            
                            SecureField("Password", text: $viewModel.password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Button {
                                viewModel.tryLogin()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.blue)
                                    Text("Login")
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                .frame(height: 44)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        
                        VStack {
                            Text("New around here?")
                            NavigationLink("create An Account",destination : RegisterView(viewModel: viewModel))
                                .padding(.bottom, 50)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
            }
            
        }
    }
}
