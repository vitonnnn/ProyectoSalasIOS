//
//  Model.swift
//  SalasB
//
//  Created by Angela Serantes Casado on 11/2/25.
//

import Foundation

// Estructura para representar una sala simplificada
struct SalaSimplificada: Identifiable{
    var id: Int
    var name: String
    var maximum_capacity: Int
}

// Estructura para representar un usuario
struct User {
    var email: String
}

// Estructura para representar una reserva de sala
struct BookingResponse {
    var user: User
    var room: SalaSimplificada
    var start_date_time: String
    var end_date_time: String
    var reason: String
    var recurrence_type: String
    var recurrence_end_date: Date?
    var guests: [String]
}
