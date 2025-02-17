//
//  ReservasListScreen.swift
//  App_Salas
//
//  Created by Ignacio on 17/2/25.
//


import SwiftUI

struct ReservasListScreen: View {
    let reservas = [
        SalaReservada(nombreSala: "BE301", nombreUsuario: "guillermo.viton@live.u-tad.com", asistentes: 6),
        SalaReservada(nombreSala: "BE303", nombreUsuario: "angela.serantes@live.u-tad.com", asistentes: 13)
    ]
    
    var body: some View {
        NavigationView {
            List(reservas) { reserva in
                SalaReservadaRow(sala: reserva)
            }
            .navigationTitle("Mis Reservas")
        }
    }
}
