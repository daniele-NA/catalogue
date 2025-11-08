import SwiftUI


// System image called as strings //
struct DashboardView: View {
    
    var body: some View {
        TabView{
            ItemsView().tabItem{Label("Items",systemImage: "house")}
        
            
            ProfileView().tabItem{Label("Profile",systemImage: "person.circle")}
        }
        
    }
}

#Preview {
    DashboardView()
}
