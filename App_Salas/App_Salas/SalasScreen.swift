//
//  SalasScreen.swift
//  App_Salas
//
//  Created by Ignacio on 17/2/25.
//


import SwiftUI

struct SalasScreen: View {
    let salas = [
        SalaDisponible(nombreSala: "BE302", capacidad: 20),
        SalaDisponible(nombreSala: "BE304", capacidad: 25),
        SalaDisponible(nombreSala: "BE306", capacidad: 15)
    ]
    
    var body: some View {
        NavigationView {
            List(salas) { sala in
                NavigationLink(destination: HorarioSalasScreen(salaId: sala.id.hashValue)) {
                    SalaDisponibleRow(sala: sala)
                }
            }
            .navigationTitle("Salas Disponibles")
        }
    }
}
