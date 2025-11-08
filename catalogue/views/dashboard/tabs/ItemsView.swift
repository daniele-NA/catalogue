import SwiftUI

struct ItemsView: View {
    @StateObject private var viewModel = ItemsViewModel()
    @State private var showNewItem = false

    var body: some View {
        NavigationStack {
            List(viewModel.currentItems, id: \ItemDto.id) {
                // Per ogni item
                item in
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title).font(.headline)
                    Text(item.description).font(.subheadline)
                    Text("€\(item.price, specifier: "%.2f")").font(.caption)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Catalogue")
            .toolbar {
                Button {
                    showNewItem = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .navigationDestination(isPresented: $showNewItem) {
                NewItemView { title, desc, price in
                    viewModel.saveNewItem(title: title, description: desc, price: price)
                    showNewItem = false
                }
            }
        }
    }
}
