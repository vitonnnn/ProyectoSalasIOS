//
//  BusquedaScreen.swift
//  App_Salas
//
//  Created by Ignacio on 17/2/25.
//


import SwiftUI

struct BusquedaScreen: View {
    @State private var buscar = false
    @State private var selectedDate = Date()
    
    //Datos de test para poder ver un minimo de info en la App
    let listaSalaDisponible = [
        SalaDisponible(nombreSala: "BE302", capacidad: 20),
        SalaDisponible(nombreSala: "BE304", capacidad: 25)
    ]
    
    //Datos de test para poder ver un minimo de info en la App
    let listaSalaReservada = [
        SalaReservada(nombreSala: "BE301", nombreUsuario: "guillermo.viton@live.u-tad.com", asistentes: 6),
        SalaReservada(nombreSala: "BE303", nombreUsuario: "angela.serantes@live.u-tad.com", asistentes: 13)
    ]
    
    //Estrucutura de la vista
    var body: some View {
        VStack {
            Text("Búsqueda de Salas")
                .font(.largeTitle)
                .padding()
            
            HStack {
                DatePicker("Selecciona fecha", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .padding()
                
                Button("Buscar") {
                    buscar = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            Divider()
            
            if buscar {
                SalaSection(title: "Salas Disponibles", salas: listaSalaDisponible.map { AnySala.salaDisponible($0) })
                SalaSection(title: "Salas Reservadas", salas: listaSalaReservada.map { AnySala.salaReservada($0) })
            }
        }
        .padding()
    }
}
