import SwiftUI

class SalasViewModel: ObservableObject {
    @Published var salas: [SalaSimplificada] = []
    
    func setSalasSimplificadas() {
        salas = [
            SalaSimplificada(id: 1, name: "Sala B301", maximum_capacity: 10),
            SalaSimplificada(id: 2, name: "Sala B302", maximum_capacity: 20),
            SalaSimplificada(id: 3, name: "Sala B303", maximum_capacity: 15),
            SalaSimplificada(id: 4, name: "Sala B304", maximum_capacity: 40)
        ]
    }
}

struct SalasScreen: View {
    @StateObject private var viewModel = SalasViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Salas")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.bottom, 16)
                
                List(viewModel.salas) { sala in
                    NavigationLink {
                        HorarioSalasScreen(salaId: sala.id)
                    } label: {
                        SalaCard(nombre: sala.name, capacidad: sala.maximum_capacity)
                    }
                }
            }
        }
        .onAppear {
            viewModel.setSalasSimplificadas()
        }
    }
}

struct SalaCard: View {
    let nombre: String
    let capacidad: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Nombre: \(nombre)")
                .font(.headline)
            Text("Capacidad: \(capacidad)")
                .font(.subheadline)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SalasScreen()
    }
}
