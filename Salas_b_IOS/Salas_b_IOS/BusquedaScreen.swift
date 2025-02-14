//
//  BusquedaScreen.swift
//  SalasB
//
//  Created by Ivan De Diego Lourido on 13/2/25.
//


import SwiftUI

struct BusquedaScreen: View {
    @State private var buscar = false
    
    let listaSalaDisponible = [
        SalaDisponible(nombreSala: "BE302", capacidad: 20),
        SalaDisponible(nombreSala: "BE304", capacidad: 25)
    ]
    
    let listaSalaReservada = [
        SalaReservada(nombreSala: "BE301", nombreUsuario: "guillermo.viton@live.u-tad.com", asistentes: 6),
        SalaReservada(nombreSala: "BE303", nombreUsuario: "angela.serantes@live.u-tad.com", asistentes: 13)
    ]
    
    var body: some View {
        VStack {
            Text("Búsqueda de Salas")
                .font(.largeTitle)
                .padding()
            
            HStack {
                SelectorHoras()
                Button("Buscar") {
                    buscar = true
                }
                .padding()
            }
            Divider()
            
            if buscar {
                SalaSection(title: "Salas Disponibles", salas: listaSalaDisponible.map { AnySala.salaDisponible($0) })
                SalaSection(title: "Salas Reservadas", salas: listaSalaReservada.map { AnySala.salaReservada($0) })
            }
        }
    }
}

enum AnySala: Identifiable {
    case salaDisponible(SalaDisponible)
    case salaReservada(SalaReservada)
    
    var id: UUID {
        switch self {
        case .salaDisponible(let sala): return sala.id
        case .salaReservada(let sala): return sala.id
        }
    }
}

struct SelectorHoras: View {
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    
    var body: some View {
        VStack {
            Button("Seleccionar Fecha") {
                showDatePicker.toggle()
            }
            .padding()
            
            if showDatePicker {
                DatePicker("Selecciona una fecha", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
            }
        }
    }
}


struct SalaDisponible: Identifiable {
    let id = UUID()
    let nombreSala: String
    let capacidad: Int
}

struct SalaReservada: Identifiable {
    let id = UUID()
    let nombreSala: String
    let nombreUsuario: String
    let asistentes: Int
}

struct SalaReservadaRow: View {
    let sala: SalaReservada
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(sala.nombreSala).font(.headline)
            Text("Reservado por: \(sala.nombreUsuario)")
                .font(.subheadline)
            Text("Asistentes: \(sala.asistentes)")
                .font(.subheadline)
        }
        .padding()
    }
}


struct SalaDisponibleRow: View {
    let sala: SalaDisponible
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(sala.nombreSala).font(.headline)
            Text("Capacidad: \(sala.capacidad)")
                .font(.subheadline)
        }
        .padding()
    }
}

struct SalaSection: View {
    let title: String
    let salas: [AnySala]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            Divider()
            
            List(salas) { sala in
                switch sala {
                case .salaDisponible(let disponible):
                    SalaDisponibleRow(sala: disponible)
                case .salaReservada(let reservada):
                    SalaReservadaRow(sala: reservada)
                }
            }
        }
    }
}

 #Preview {
     BusquedaScreen()
         
 }
