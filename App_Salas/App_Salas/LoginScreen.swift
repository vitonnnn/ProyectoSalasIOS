//
//  LoginScreen.swift
//  App_Salas
//
//  Created by Ignacio on 17/2/25.
//


import SwiftUI

struct LoginScreen: View {
    //Inicializamos las variables necesaras varias 
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isLoggedIn = false
    
    var body: some View {
        if isLoggedIn {
            ContentView() // Redirigir a la aplicación después del login
        } else {
            VStack {
                Text("Iniciar Sesión")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                VStack(alignment: .center, spacing: 20) {
                    // Campo de correo
                    TextField("Correo electrónico", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                        .keyboardType(.emailAddress)
                    
                    // Campo de contraseña con botón de visibilidad
                    VStack {
                        if isPasswordVisible {
                            TextField("Contraseña", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 20)
                        } else {
                            SecureField("Contraseña", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 20)
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Text(isPasswordVisible ? "Ocultar contraseña" : "Mostrar contraseña")
                                .foregroundColor(.blue)
                                .padding(.top, 8)
                        }
                    }
                    
                    // Mensaje de error
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                    }
                    
                    // Botón de login
                    Button(action: {
                        if email.isEmpty || password.isEmpty {
                            errorMessage = "Por favor, complete todos los campos."
                        } else {
                            errorMessage = ""
                            isLoggedIn = true
                        }
                    }) {
                        Text("Iniciar sesión")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                    }
                    .frame(height: 50)
                    .padding(.top, 16)
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .background(Color.white)
            .ignoresSafeArea()
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
