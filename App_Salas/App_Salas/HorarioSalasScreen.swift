//
//  HorarioSalasScreen.swift
//  App_Salas
//
//  Created by Ignacio on 17/2/25.
//


import SwiftUI

struct HorarioSalasScreen: View {
    @StateObject private var viewModel = HorarioSalasViewModel()
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    let salaId: Int

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView().padding()
                } else {
                    Text("Horario de Sala")
                        .font(.title)
                        .padding()
                    
                    HStack {
                        Button("◀") {
                            selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
                            viewModel.fetchReservas(salaId: salaId, date: selectedDate)
                        }
                        
                        Button(action: { showDatePicker = true }) {
                            Text(selectedDate.formatted(date: .abbreviated, time: .omitted))
                        }
                        
                        Button("▶") {
                            selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
                            viewModel.fetchReservas(salaId: salaId, date: selectedDate)
                        }
                    }
                    .padding()
                    
                    if showDatePicker {
                        DatePicker("Selecciona una fecha", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .padding()
                            .onChange(of: selectedDate) { newDate in
                                viewModel.fetchReservas(salaId: salaId, date: newDate)
                                showDatePicker = false
                            }
                    }
                    
                    List(viewModel.timeRanges) { range in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(range.timeSlots[0])
                                Text("-")
                                Text(range.timeSlots[2])
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                            Spacer()
                            
                            if range.isReserved {
                                Text("No Disponible").foregroundColor(.red)
                            } else {
                                NavigationLink {
                                    Text("Formulario de reserva")
                                } label: {
                                    Text("Reservar")
                                }
                            }
                        }
                        .padding(8)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchReservas(salaId: salaId, date: selectedDate)
        }
    }
}

struct TimeRange: Identifiable {
    let id = UUID()
    let timeSlots: [String]
    let isReserved: Bool
}

class HorarioSalasViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var timeRanges: [TimeRange] = []
   
    func fetchReservas(salaId: Int, date: Date) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let allReservas = self.fakeReservas()
            let filteredReservas = allReservas.filter { Calendar.current.isDate($0.startDateTime, inSameDayAs: date) }
            self.timeRanges = self.generateTimeRanges(reservas: filteredReservas)
            self.isLoading = false
        }
    }
   
    func generateTimeRanges(reservas: [HorarioReserva]) -> [TimeRange] {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
       
        var ranges: [TimeRange] = []
        let startTime = Calendar.current.startOfDay(for: Date())
        let endTime = Calendar.current.date(bySettingHour: 23, minute: 59, second: 0, of: Date())!
       
        for reserva in reservas {
            ranges.append(TimeRange(timeSlots: [formatter.string(from: reserva.startDateTime), "-", formatter.string(from: reserva.endDateTime)], isReserved: true))
        }
        
        return ranges
    }
   
    func fakeReservas() -> [HorarioReserva] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return [
            HorarioReserva(id: 1, startDateTime: formatter.date(from: "2025-02-11 09:00")!, endDateTime: formatter.date(from: "2025-02-11 10:30")!)
        ]
    }
}

struct HorarioReserva {
    let id: Int
    let startDateTime: Date
    let endDateTime: Date
}
