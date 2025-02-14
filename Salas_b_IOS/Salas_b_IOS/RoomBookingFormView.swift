//
//  ContentView.swift
//  SalasB
//
//  Created by Angela Serantes Casado on 11/2/25.

import SwiftUI

// Vista que maneja la reserva de una sala
struct RoomBookingFormView: View {
    // Estado para saber si es una nueva reserva o una edición
    @State var isNewReserva = true
    @State var bookingID: Int? = nil

    // Fechas de inicio y fin de la reserva
    @State var fechaInicio = Date()
    @State var fechaFin = Date()

    // Información de la sala seleccionada
    @State var sala: SalaSimplificada

    // Tipo de recurrencia y fecha de fin de recurrencia
    @State private var recurrenceType = "none"
    @State private var recurrenceEndDate: Date = Date()

    // Datos de la reserva actual
    @State private var reserva: BookingResponse? = nil

    // Campos para la lista de asistentes
    @State private var guestEmail: String = ""
    @State private var guests: [String] = []

    // Campo para la razón de la reserva
    @State private var bookingReason: String = ""

    // Mensaje de error en caso de validaciones fallidas
    @State private var errorMessage: String? = nil
    
    @State private var reservaGuardada = false

    // Opciones de recurrencia disponibles
    let recurrenceOptions = ["none", "diario", "semanal", "mensual"]

    var body: some View {
        NavigationView {
            Form {
                // Sección para seleccionar la sala y las fechas de reserva
                Section(header: Text("Detalles de la Reserva")) {
                    VStack(alignment: .leading){
                        Text(sala.name)
                            .font(.title)
                        Text("Capacidad: \(sala.maximum_capacity)")
                        
                        // Selección de fecha y hora de inicio y fin
                        DatePicker("Inicio", selection: $fechaInicio, displayedComponents: [.date, .hourAndMinute])
                        DatePicker("Fin", selection: $fechaFin, displayedComponents: [.date, .hourAndMinute])
                        
                        // Selección del tipo de recurrencia
                        Picker("Recurrencia", selection: $recurrenceType) {
                            ForEach(recurrenceOptions, id: \.self) { option in
                                Text(option.capitalized).tag(option)
                            }
                        }
                        
                        // Fecha de fin de la recurrencia (si aplica)
                        if recurrenceType != "none" {
                            DatePicker("Fin de recurrencia", selection: $recurrenceEndDate, displayedComponents: .date)
                        }
                    }
                }

                // Sección para introducir el motivo de la reserva
                Section(header: Text("Motivo de la Reserva")) {
                    TextField("Introduce la razón de la reserva", text: $bookingReason, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                }

                // Sección para añadir asistentes a la reserva
                Section(header: Text("Asistentes")) {
                    HStack {
                        // Campo para ingresar el email de un asistente
                        TextField("Correo del asistente", text: $guestEmail)
                            .keyboardType(.emailAddress)

                        // Botón para agregar el asistente a la lista
                        Button("Añadir") {
                            agregarAsistente()
                        }
                    }

                    // Lista de asistentes agregados con opción para eliminarlos
                    List {
                        ForEach(guests, id: \.self) { guest in
                            Text(guest)
                        }
                        .onDelete(perform: { indexSet in
                            guests.remove(atOffsets: indexSet)
                        })
                    }
                }

                // Muestra el mensaje de error si hay problemas con la validación
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                if reservaGuardada {
                    Text("¡Reserva guardada correctamente!")
                        .foregroundColor(.green)
                }

                // Botón para guardar o actualizar la reserva
                Button(action: guardarReserva) {
                    Text(isNewReserva ? "Reservar" : "Actualizar Reserva")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle(isNewReserva ? "Nueva Reserva" : "Editar Reserva")
            .onAppear {
                if !isNewReserva {
                    cargarReservaExistente()
                }
            }
        }
    }

    // Función para agregar un asistente a la lista
    private func agregarAsistente() {
        guard !guestEmail.isEmpty else { return }

        // Validar que el email sea correcto
        if !esEmailValido(guestEmail) {
            errorMessage = "El email no es válido."
            return
        }

        // Validar que el email no esté duplicado
        if guests.contains(guestEmail) {
            errorMessage = "El email ya ha sido añadido."
            return
        }

        // Agregar el email a la lista y limpiar el campo de entrada
        guests.append(guestEmail)
        guestEmail = ""
        errorMessage = nil
    }

    // Función para validar el formato de un email
    private func esEmailValido(_ email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return email.range(of: emailRegex, options: .regularExpression) != nil
    }

    // Función para validar las fechas antes de guardar la reserva
    private func validarFechas() -> Bool {
        // Comprobar que la fecha de fin sea posterior a la de inicio
        if fechaFin <= fechaInicio {
            errorMessage = "La fecha de fin debe ser posterior a la fecha de inicio."
            return false
        }

        // Limitar la duración de la reserva a un máximo de un día
        let unDia: TimeInterval = 24 * 60 * 60
        if fechaFin.timeIntervalSince(fechaInicio) > unDia {
            errorMessage = "La duración de la reserva no puede ser mayor a 1 día."
            return false
        }

        // Validar que la fecha de fin de la recurrencia sea posterior a la reserva
        if recurrenceType != "none", recurrenceEndDate < fechaInicio {
            errorMessage = "La fecha de fin de recurrencia no puede ser antes de la fecha de inicio."
            return false
        }

        errorMessage = nil
        return true
    }

    // Función para guardar la reserva después de validar los datos
    private func guardarReserva() {
        if !validarFechas() {
            return
        }
        reservaGuardada = true
        // TODO: Reservar conectando a la API
    }

    // Función para cargar los datos de una reserva existente (a implementar)
    private func cargarReservaExistente() {
        // TODO: Conectar con la API para recibir los datos de la reserva a modificar
    }
}

// Vista previa de la aplicación en SwiftUI
#Preview {
    RoomBookingFormView(sala: .testRoom)
}
