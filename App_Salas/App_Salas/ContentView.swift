//
//  ContentView.swift
//  App_Salas
//
//  Created by Ignacio on 17/2/25.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        //Configuracion de botones de la BottomBar para la Navegacion interna
        TabView {
            SalasScreen()
                .tabItem {
                    Label("Salas", systemImage: "house")
                }
            
            BusquedaScreen()
                .tabItem {
                    Label("Búsqueda", systemImage: "magnifyingglass")
                }
            
            ReservasListScreen()
                .tabItem {
                    Label("Mis Reservas", systemImage: "calendar")
                }
        }
    }
}
