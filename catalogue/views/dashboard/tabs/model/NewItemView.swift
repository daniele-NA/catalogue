import SwiftUI

typealias Title = String
typealias Description = String
typealias Price = Float

// == SingleItemPage == //
struct NewItemView: View {
    
    var onSave: (Title, Description, Price) -> Void   // callback
    
    @State private var title = ""
    @State private var description = ""
    @State private var price: Float = 0.0
    
    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
            
            Text("Fill all the fields")
                .font(.system(size: 20))
            
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
                TextField("Price", value: $price, format: .number)
                
                Button {
                    
                    if !title.isEmpty && !description.isEmpty && price != 0 {
                        onSave(title, description, price)
                    }
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue)
                        Text("Confirm")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .frame(height: 44)
                }
            }
        }
    }
}

#Preview {
    NewItemView { title, desc, price in
        print("Saved item: \(title) - \(desc) - \(price)")
    }
}

