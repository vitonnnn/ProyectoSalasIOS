//
//  LoginScreen.swift
//
//
//  Created by Ignacio on 14/2/25.
//


import SwiftUI

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var isPasswordVisible: Bool = false
    
    var onClickLogIn: () -> Void
    
    var body: some View {
        VStack {
            // Título
            Text("Iniciar Sesión")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50)
            
            VStack(alignment: .center, spacing: 20) {
                // Campo de correo
                TextField("Correo electrónico", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                    .keyboardType(.emailAddress)
                
                // Campo de contraseña
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
                        .padding(.top, 8)
                }
                
                // Botón de login
                Button(action: {
                    if email.isEmpty || password.isEmpty {
                        errorMessage = "Por favor, complete todos los campos."
                    } else {
                        errorMessage = ""
                        onClickLogIn()
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
                
                // Botón de invitado (opcional)
                Button(action: {
                    // Acción para Invitado
                }) {
                    Text("Entrar como invitado")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.orange))
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                }
                .frame(height: 50)
                .padding(.top, 8)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen {
            // Acción del login
        }
    }
}
