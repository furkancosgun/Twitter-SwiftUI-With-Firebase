//
//  LoginView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        VStack(alignment: .leading){
            AuthHeaderView(firstTitle: "Hello.", secondTitle: "Welcome Back")
                
            VStack(spacing: 40){
                CustomInputView(imageName: "envelope", placeHolderText: "Email", isSecureField: false, text: $email)
                
                CustomInputView(imageName: "lock", placeHolderText: "Password", isSecureField: true, text: $password)
                
            }.padding(.horizontal,22)
                .padding(.vertical,40)
            
            HStack{
                Spacer()
                NavigationLink{
                    
                }label: {
                    Text("Reset Password view..")
                        .font(.caption)
                        .foregroundColor(.blue)
                        .bold()
                        .padding(.horizontal)
                }
            }.padding(.bottom,15)
            HStack{
                Spacer()
                Button{
                    viewModel.login(withEmail: email, password: password)
                }label: {
                    Text("Sign In")
                    .padding(.vertical,12)
                    .padding(.horizontal,120)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }.padding()
                  
                Spacer()
            }
            Spacer()
            
            NavigationLink{
                RegistirationView()
                    .navigationBarHidden(true)
            }label: {
                HStack(alignment: .center){
                    Spacer()
                    Text("Don't have an account?")
                    Text("Sign Up")
                        .font(.headline)
                    Spacer()
                }.padding(.bottom,40)
                    .foregroundColor(.blue)
            }
        }.ignoresSafeArea()
            .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
