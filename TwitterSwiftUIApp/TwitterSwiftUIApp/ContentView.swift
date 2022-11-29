//
//  ContentView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @State private var showMenu = true
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        Group{
            if viewModel.userSession == nil {
                LoginView()
            }else{
               mainInterfaceView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}

extension ContentView {
    var mainInterfaceView : some View {
        ZStack(alignment: .topLeading){
            MainTabView()
                .navigationBarHidden(showMenu)
            if showMenu {
                ZStack{
                    Color(.black)
                        .opacity(showMenu ? 0.25 : 0)
                }.onTapGesture {
                    withAnimation(.easeInOut){
                        showMenu = false
                    }
                }.ignoresSafeArea()
            }
            SideMenuView()
                .frame(width: 300)
                .background(Color.white)
                .offset(x:showMenu ? 0 : -300 ,y:0)
                .background(showMenu ? Color.white : Color.clear)
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                if let user = viewModel.currentUser{
                    Button{
                        withAnimation(.easeInOut){
                            self.showMenu.toggle()
                        }
                    }
                    label:{
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 35,height:35)
                            
                    }
                }
                
            }
            
        }.onAppear{
            showMenu = false
        }
    }
}
