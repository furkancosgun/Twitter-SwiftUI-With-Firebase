//
//  SideMenuView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    var body: some View {
        if let user = authViewModel.currentUser{
            VStack(alignment: .leading) {
                VStack(alignment: .leading){
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 50,height:50)
                        
                    Text(user.fullname)
                            .font(.headline)
                        
                    Text("@\(user.username)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        UserStatsView().padding(.vertical)
                }

                ForEach(SideMenuViewModel.allCases,id:\.rawValue){ item in
                    if item == .profile {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            SideMenuRowView(viewmodel: item)
                        }
                    }else if item == .logout{
                        Button {
                            authViewModel.signOut()
                        } label: {
                            SideMenuRowView(viewmodel: item)
                        }
                    }
                    else {
                        SideMenuRowView(viewmodel: item)
                    }
                 
                }
                Spacer()
            }.padding()
        }
        
    }
    
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}

