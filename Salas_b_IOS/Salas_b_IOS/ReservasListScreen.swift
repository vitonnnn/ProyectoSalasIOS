//
//  ReservasListScreen.swift
//  SalasB_IOS
//
//  Created by Javier Arévalo Hernández on 14/2/25.
//

import SwiftUI

import SwiftUI

struct Reserva: Identifiable {
    let id: Int
    let usuarioID: Int
    let salaID: Int
    let nombreSala: String
    let capacidadMaximaSala: Int
    let fechaHoraInicio: Date
    let fechaHoraFin: Date
    let motivo: String
    let cantidadAsistentes: Int
    let tipoRecurrencia: String
    let fechaFinRecurrencia: Date
}

struct ReservasListScreen: View {
    let fechaHoy = Date()
    
    let reservas: [Reserva] = [
        Reserva(id: 1, usuarioID: 101, salaID: 1, nombreSala: "Sala A", capacidadMaximaSala: 50,
                fechaHoraInicio: Calendar.current.date(byAdding: .day, value: 0, to: Date())!,
                fechaHoraFin: Calendar.current.date(byAdding: .hour, value: 2, to: Date())!,
                motivo: "Reunión de equipo", cantidadAsistentes: 15,
                tipoRecurrencia: "Ninguna", fechaFinRecurrencia: Date()),
        Reserva(id: 2, usuarioID: 102, salaID: 2, nombreSala: "Sala B", capacidadMaximaSala: 30,
                fechaHoraInicio: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
                fechaHoraFin: Calendar.current.date(byAdding: .hour, value: 2, to: Date())!,
                motivo: "Presentación de proyecto", cantidadAsistentes: 25,
                tipoRecurrencia: "Semanal", fechaFinRecurrencia: Date())
    ]
    
    var body: some View {
        NavigationView {
            List {
                SeccionReservas(titulo: "Reservas de Hoy", reservas: reservas.filter { Calendar.current.isDate($0.fechaHoraInicio, inSameDayAs: fechaHoy) })
                SeccionReservas(titulo: "Próximas Reservas", reservas: reservas.filter { $0.fechaHoraInicio > fechaHoy })
                SeccionReservas(titulo: "Reservas Anteriores", reservas: reservas.filter { $0.fechaHoraInicio < fechaHoy })
            }
            .navigationTitle("Reservas")
        }
    }
}

struct SeccionReservas: View {
    let titulo: String
    let reservas: [Reserva]
    
    var body: some View {
        Section(header: Text(titulo).font(.headline)) {
            if reservas.isEmpty {
                Text("No hay reservas \(titulo.lowercased()).")
                    .foregroundColor(.gray)
            } else {
                ForEach(reservas) { reserva in
                    ReservaItem(reserva: reserva)
                }
            }
        }
    }
}

struct ReservaItem: View {
    let reserva: Reserva
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(reserva.nombreSala)
                .font(.headline)
            Text("Motivo: \(reserva.motivo)")
                .font(.subheadline)
            Text("Fecha: \(reserva.fechaHoraInicio.formatted(date: .abbreviated, time: .shortened))")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
    }
}
