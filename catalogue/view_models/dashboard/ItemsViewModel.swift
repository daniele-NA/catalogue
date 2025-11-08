import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

final class ItemsViewModel: ObservableObject {
    
    @Published var currentItems: [ItemDto] = []
    
    private let db = Firestore.firestore()
    private let collectionName = "items"
    
    init() {
        fetchItems()
    }
    
    private func fetchItems() {
        db.collection(collectionName)
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print("Errore durante il fetch: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                let items = documents.compactMap { doc -> ItemDto? in
                    try? doc.data(as: ItemDto.self)
                }
                
                DispatchQueue.main.async {
                    self?.currentItems = items
                }
            }
    }
    
    
    
    func saveNewItem(title: String, description: String, price: Float) {
        guard !title.isEmpty, !description.isEmpty, price != 0 else {
            print("Campi mancanti o non validi")
            return
        }
        
        guard let user = AuthViewModel.user else {
            print("Nessun utente loggato")
            return
        }
        
        let docRef = db.collection(collectionName).document() // 🔹 genera ID unico

        // Crea DTO
        let newItem = ItemDto(
            id: docRef.documentID,
            createdBy: user.uid,
            title: title,
            description: description,
            price: price,
            createdAt: Date().timeIntervalSince1970
        )
        
        // Salva su Firestore
        db.collection(collectionName).document(user.uid).setData([
            "id":newItem.id,
            "createdBy": newItem.createdBy,
            "title": newItem.title,
            "description": newItem.description,
            "price": newItem.price,
            "createdAt": newItem.createdAt
        ]) { err in
            if let err = err {
                print("Errore durante l'inserimento: \(err.localizedDescription)")
            } else {
                print("Nuovo item creato: \(newItem)")
                self.currentItems.append(newItem)
            }
        }
    }
}
