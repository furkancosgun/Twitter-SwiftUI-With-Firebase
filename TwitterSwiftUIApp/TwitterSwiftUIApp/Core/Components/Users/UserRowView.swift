//
//  UserRowView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    let user : User
    var body: some View {
        HStack(spacing: 10){
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .frame(width: 50,height: 50)
                .scaledToFill()
                .clipShape(Circle())
            
            VStack(alignment: .leading,spacing: 5){
                Text(user.username).font(.headline)
                Text(user.fullname).font(.subheadline)
            }.foregroundColor(.black)
            Spacer()
        }.padding(.vertical,5)
            .padding(.horizontal,10)
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User(username: "", fullname: "", profileImageUrl: "", email: ""))
    }
}
