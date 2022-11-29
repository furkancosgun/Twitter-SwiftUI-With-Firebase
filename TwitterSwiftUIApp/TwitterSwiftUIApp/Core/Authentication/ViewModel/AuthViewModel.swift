//
//  AuthViewModel.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI
import Firebase


class AuthViewModel : ObservableObject {
    @Published var userSession : FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var isLoading = false
    @Published var currentUser : User?
    private let service = UserService()
    private var  tempUserSession : FirebaseAuth.User?
    init(){
        self.userSession = Auth.auth().currentUser
        print("DEBUG: userSession: \(self.userSession?.uid ?? "nil")")
        self.fetchUser()
    }
    
    func login(withEmail email:String,password:String){
        self.isLoading = true
        Auth.auth().signIn(withEmail: email, password: password){ result,error in
            if let error = error {
                print("DEBUG: Failed to Login with error \(error.localizedDescription)")
                self.isLoading = false
                return
            }
            guard let user = result?.user else {return}
            self.userSession = user
            self.fetchUser()
            self.isLoading = false
        }
    }
    
    func register(withEmail email:String,password:String,fullName:String,userName:String){
        self.isLoading = true
        Auth.auth().createUser(withEmail: email, password: password){ result,error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                self.isLoading = false
                return
            }
            
            guard let user = result?.user else {return}
            self.tempUserSession = user
            
            let data = ["email":email,
                        "username":userName.lowercased(),
                        "fullname":fullName,
                        "uid":user.uid]
            Firestore.firestore()
                .collection("users")
                .document(user.uid)
                .setData(data){ _ in
                print("DEBUG: Did upload user data")
                    self.didAuthenticateUser = true
                    
                    self.isLoading = false
            }
        }
    }
    func signOut(){
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func uploadProfileImage(_ image:UIImage){
        guard let uid  = self.tempUserSession?.uid else {return}
        
        ImageUploader.uploadImage(image: image, completion: { path in
            Firestore.firestore()
                .collection("users")
                .document(uid)
                .updateData(["profileImageUrl":path]){ _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        })
    }
    
    func fetchUser(){
        guard let uid = userSession?.uid else {return}
        service.fetchUser(withUid: uid){ user in
            self.currentUser = user
        }
        
    }
}
