//
//  UserStatsView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI

struct UserStatsView: View {
    var body: some View {
        HStack(spacing:20 ){
            HStack{
                Text("1")
                    .bold()
                    .font(.subheadline)
            
                Text("Following")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            HStack{
                Text("1m")
                    .font(.subheadline).bold()
                Text("Followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
        }.padding(.vertical,5)
    }
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView()
    }
}
