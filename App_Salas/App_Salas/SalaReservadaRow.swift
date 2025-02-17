//
//  SalaReservadaRow.swift
//  App_Salas
//
//  Created by Ignacio on 17/2/25.
//


import SwiftUI

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
