import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SalasScreen()
                .tabItem {
                    Label("Salas", systemImage: "house")
                }
            
            BusquedaScreen()
                .tabItem {
                    Label("Búsqueda", systemImage: "magnifyingglass")
                }
            
            ReservasListScreen()
                .tabItem {
                    Label("Mis Reservas", systemImage: "calendar")
                }
        }
    }
}

@main
struct ReservasApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
