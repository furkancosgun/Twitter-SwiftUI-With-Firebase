//
//  RegistirationView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI

struct RegistirationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var fullname = ""
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
       
       
        VStack(alignment: .leading){
                    
           AuthHeaderView(firstTitle: "Get Started.", secondTitle: "Create Your Account")
 
                InputsView
            
          
            HStack{
                Spacer()
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(width: UIScreen.main.bounds.width - 50,height: 50)
                    .scaleEffect(1, anchor: .center)
                    .background(Color.blue)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .clipShape(Capsule())
                        .padding()
                }else{
                    Group{
                        if viewModel.didAuthenticateUser{
                            
                            NavigationLink{
                                ProfilePhotoSelectorView()
                            }label: {
                                Text("Continue")
                            }
                            .frame(width: UIScreen.main.bounds.width - 50,height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .padding()
                        }else{
                            Button {
                                viewModel.register(withEmail: email, password: password, fullName: fullname, userName: username)
                                
                            }label: {
                                Text("Sign Up")
                                    .frame(width: UIScreen.main.bounds.width - 50,height: 50)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                                    .padding()
                            }
                        }
                    }
                }
                
    
                
                Spacer()
            }
            
            Spacer()
            
            Button{
                    mode.wrappedValue.dismiss()
            }label: {
                HStack(alignment: .center){
                    Spacer()
                    Text("Already have an account?")
                    Text("Sign In")
                        .font(.headline)
                    Spacer()
                }.padding(.bottom,40)
                    .foregroundColor(.blue)
            }
            
        }.ignoresSafeArea()
            .navigationBarHidden(true)
        
    }
    func isLoading(){
        
    }
    
}

private struct viewModiferIsmi : ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(width: 100,height: 100)
    }
}

 
struct RegistirationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistirationView()
    }
}

extension RegistirationView{
    var InputsView : some View{
        VStack(spacing: 40){
            CustomInputView(imageName: "envelope", placeHolderText: "Email", isSecureField: false,text: $email)
            
            CustomInputView(imageName: "person", placeHolderText: "Username",isSecureField: false, text: $username)
            
            CustomInputView(imageName: "person", placeHolderText: "Full name",isSecureField: false, text: $fullname)
            
            CustomInputView(imageName: "lock", placeHolderText: "Password",isSecureField: true, text: $password)
            
        }.padding(.horizontal,22)
            .padding(.vertical,40)
    }
    
    
}


