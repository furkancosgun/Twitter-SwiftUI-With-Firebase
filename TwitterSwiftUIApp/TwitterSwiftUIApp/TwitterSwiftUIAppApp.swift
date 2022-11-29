//
//  TwitterSwiftUIAppApp.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI
import Firebase

@main
struct TwitterSwiftUIAppApp: App {
    @StateObject var viewModel = AuthViewModel()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                
            ContentView()
               
            }.environmentObject(viewModel)
        }
    }
}
