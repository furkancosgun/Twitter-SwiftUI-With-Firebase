//
//  AuthHeaderView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 27.11.2022.
//

import SwiftUI

struct AuthHeaderView: View {
    var firstTitle : String
    var secondTitle : String
    var body: some View {
         VStack(alignment: .leading){
            Text(firstTitle).font(.largeTitle)
                .bold()
                .padding(.leading)
            Text(secondTitle).font(.largeTitle)
                .bold()
                .padding(.leading)
            HStack{Spacer()}
        }.frame(height: 260)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedShape(corners: [.bottomRight],radius:CGSize(width: 80, height: 80)))
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView(firstTitle: "Hello.", secondTitle: "Welcome Back")
    }
}
