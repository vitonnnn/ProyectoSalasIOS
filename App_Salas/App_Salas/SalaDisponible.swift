//
//  SalaDisponible.swift
//  App_Salas
//
//  Created by Ignacio on 17/2/25.
//


import SwiftUI

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
